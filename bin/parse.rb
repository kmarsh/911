#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'

require 'pg'
require 'oj'
# http://www.scribekey.com/EntityAttributes/EDGES.html
# STATEFP: 39
# COUNTYFP: 095
# TLID: 33944600, 33953945, 33944650, 618108226, 618108195, 33944693, 618105833, 33944652, 33963232, 33950258
# TFIDL: 201617577, 201617578, 201627484, 201617583, 201617585, 201617589, 201627485, 201626446, 201621685, 229570151
# TFIDR: 201627713, 201617788, 201617583, 229570156, 229570141, 201627485, 229569274, 201617598, 201617600, 201617601
# MTFCC: S1400, P0001, S1200, S1740, R1011, S1100, H3010, P0002, P0004, H3020
# FULLNAME: Mulberry St, Saint Annes Dr, Stickney Ave, Champlain St, , N Summit St, Crane Ln, Buffalo St, N Huron St, Locust St
# SMID: 759, , 7190, 1652, 2881, 2877, 7193, 7191
# LFROMADD: 1601, 724, 1001, , 775, 1401, 801, 901, 817, 611
# LTOADD: 1699, 706, 1099, 1671, , 799, 1499, 899, 991, 815
# RFROMADD: 1600, 727, 1000, , 774, 1400, 800, 900, 818, 608
# RTOADD: 1698, 687, 1098, 1636, , 798, 1498, 898, 990, 816
# ZIPL: 43608, 43528, 43604, , 43605, 43611, 43614, 43623, 43615, 43606
# ZIPR: 43608, 43528, 43604, , 43605, 43611, 43614, 43623, 43615, 43606
# FEATCAT: S, , R, H
# HYDROFLG: N, Y
# RAILFLG: N, Y
# ROADFLG: Y, N
# OLFFLG: N, Y
# PASSFLG: , B
# DIVROAD: N, , Y
# EXTTYP: N, B, S
# TTYP: , M, S
# DECKEDROAD: N,
# ARTPATH: N, , C, U
# PERSIST: , P, I
# GCSEFLG: N, T
# OFFSETL: N, Y
# OFFSETR: N
# TNIDF: 96263424, 96251298, 96263452, 409284779, 96263479, 409283476, 96263448, 96266425, 96266424, 96263578
# TNIDT: 96263422, 96250934, 96263453, 409284798, 96263574, 96263439, 96263506, 96263454, 96269952, 96266425

conn = PG.connect()
# conn.exec("SELECT * FROM roads") do |result|
#   result.each do |row|
#     puts row['fullname']
#   end
# end

# exit 1

h2 = Oj.load(ARGF)
h2['features'].each do |feature|
  properties = feature['properties']

  next if properties['FULLNAME'].to_s.strip == ""

  linestring = feature['geometry']['coordinates'].map{|c| c.join(' ') }.join(', ')

  # puts feature['geometry']['coordinates'].to_s
  # conn.exec_params("INSERT INTO roads (TLID, FULLNAME, LFROMADD, LTOADD, RFROMADD, RTOADD, LINESTRING) VALUES (?, ?, ?, ?, ?, ?, ?)",[properties['FULLNAME']])
  conn.exec_params("INSERT INTO roads (TLID, FULLNAME, LFROMADD, LTOADD, RFROMADD, RTOADD, geom) VALUES ($1, $2, $3, $4, $5, $6, ST_GeomFromText($7))",
                   [properties['TLID'],
                   properties['FULLNAME'],
                   properties['LFROMADD'],
                   properties['LTOADD'],
                   properties['RFROMADD'],
                   properties['RTOADD'],
                   "LINESTRING(#{linestring})"])
end