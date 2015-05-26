module hecmw_msgno
    use hecmw_util

    integer(kind=kint),parameter :: HECMW_ALL_E0001 = 10001
    integer(kind=kint),parameter :: HECMW_ALL_E0101 = 10002
    integer(kind=kint),parameter :: HECMW_ALL_E0102 = 10003
    integer(kind=kint),parameter :: HECMW_ALL_E1001 = 10004
    integer(kind=kint),parameter :: HECMW_ALL_E1002 = 10005
    integer(kind=kint),parameter :: HECMW_ALL_E1003 = 10006
    integer(kind=kint),parameter :: HECMW_COUPLE_E1001 = 10007
    integer(kind=kint),parameter :: HECMW_COUPLE_E1002 = 10008
    integer(kind=kint),parameter :: HECMW_COUPLE_E1101 = 10009
    integer(kind=kint),parameter :: HECMW_COUPLE_E1102 = 10010
    integer(kind=kint),parameter :: HECMW_COUPLE_E2001 = 10011
    integer(kind=kint),parameter :: HECMW_COUPLE_E2002 = 10012
    integer(kind=kint),parameter :: HECMW_COUPLE_E2101 = 10013
    integer(kind=kint),parameter :: HECMW_COUPLE_E2111 = 10014
    integer(kind=kint),parameter :: HECMW_COUPLE_E2112 = 10015
    integer(kind=kint),parameter :: HECMW_COUPLE_E2113 = 10016
    integer(kind=kint),parameter :: HECMW_COUPLE_E2201 = 10017
    integer(kind=kint),parameter :: HECMW_COUPLE_E2211 = 10018
    integer(kind=kint),parameter :: HECMW_COUPLE_E2212 = 10019
    integer(kind=kint),parameter :: HECMW_COUPLE_E2213 = 10020
    integer(kind=kint),parameter :: HECMW_COUPLE_E2214 = 10021
    integer(kind=kint),parameter :: HECMW_COUPLE_E2301 = 10022
    integer(kind=kint),parameter :: HECMW_COUPLE_E2311 = 10023
    integer(kind=kint),parameter :: HECMW_COUPLE_E2312 = 10024
    integer(kind=kint),parameter :: HECMW_COUPLE_E2313 = 10025
    integer(kind=kint),parameter :: HECMW_COUPLE_E2321 = 10026
    integer(kind=kint),parameter :: HECMW_COUPLE_E2322 = 10027
    integer(kind=kint),parameter :: HECMW_COUPLE_E2323 = 10028
    integer(kind=kint),parameter :: HECMW_COUPLE_E2324 = 10029
    integer(kind=kint),parameter :: HECMW_COUPLE_E2325 = 10030
    integer(kind=kint),parameter :: HECMW_COUPLE_E2326 = 10031
    integer(kind=kint),parameter :: HECMW_COUPLE_E3001 = 10032
    integer(kind=kint),parameter :: HECMW_COUPLE_E3002 = 10033
    integer(kind=kint),parameter :: HECMW_COUPLE_E3003 = 10034
    integer(kind=kint),parameter :: HECMW_COUPLE_E3011 = 10035
    integer(kind=kint),parameter :: HECMW_COUPLE_E3101 = 10036
    integer(kind=kint),parameter :: HECMW_COUPLE_E3102 = 10037
    integer(kind=kint),parameter :: HECMW_COUPLE_E3103 = 10038
    integer(kind=kint),parameter :: HECMW_COUPLE_E3104 = 10039
    integer(kind=kint),parameter :: HECMW_COUPLE_E3111 = 10040
    integer(kind=kint),parameter :: HECMW_COUPLE_E3112 = 10041
    integer(kind=kint),parameter :: HECMW_COUPLE_E3121 = 10042
    integer(kind=kint),parameter :: HECMW_COUPLE_E3122 = 10043
    integer(kind=kint),parameter :: HECMW_COUPLE_E3123 = 10044
    integer(kind=kint),parameter :: HECMW_COUPLE_E3124 = 10045
    integer(kind=kint),parameter :: HECMW_COUPLE_E3125 = 10046
    integer(kind=kint),parameter :: HECMW_COUPLE_E3126 = 10047
    integer(kind=kint),parameter :: HECMW_COUPLE_E3127 = 10048
    integer(kind=kint),parameter :: HECMW_COUPLE_E3201 = 10049
    integer(kind=kint),parameter :: HECMW_COUPLE_E3202 = 10050
    integer(kind=kint),parameter :: HECMW_COUPLE_E8001 = 10051
    integer(kind=kint),parameter :: HECMW_COUPLE_E8011 = 10052
    integer(kind=kint),parameter :: HECMW_COUPLE_E8012 = 10053
    integer(kind=kint),parameter :: HECMW_COUPLE_E9999 = 10054
    integer(kind=kint),parameter :: HECMW_COUPLE_W1001 = 10055
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0001 = 10056
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0002 = 10057
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0003 = 10058
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0096 = 10059
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0098 = 10060
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0100 = 10061
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0101 = 10062
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0200 = 10063
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0300 = 10064
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0400 = 10065
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0500 = 10066
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0501 = 10067
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0502 = 10068
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0503 = 10069
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0600 = 10070
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0601 = 10071
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0603 = 10072
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0604 = 10073
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0605 = 10074
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0606 = 10075
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0700 = 10076
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0701 = 10077
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0702 = 10078
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0703 = 10079
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0800 = 10080
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0900 = 10081
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E0901 = 10082
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1000 = 10083
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1001 = 10084
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1002 = 10085
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1100 = 10086
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1101 = 10087
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1102 = 10088
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1103 = 10089
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1104 = 10090
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1105 = 10091
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1106 = 10092
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1107 = 10093
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1200 = 10094
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1300 = 10095
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1400 = 10096
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1500 = 10097
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1501 = 10098
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1502 = 10099
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1503 = 10100
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1600 = 10101
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1601 = 10102
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1700 = 10103
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1701 = 10104
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1702 = 10105
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1703 = 10106
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1704 = 10107
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1705 = 10108
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1706 = 10109
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1707 = 10110
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1800 = 10111
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1801 = 10112
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E1900 = 10113
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E2000 = 10114
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E2100 = 10115
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E2101 = 10116
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E2102 = 10117
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E2103 = 10118
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E2104 = 10119
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E2105 = 10120
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E2106 = 10121
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E2107 = 10122
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E2108 = 10123
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E2200 = 10124
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E2300 = 10125
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E2400 = 10126
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_E2500 = 10127
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_W0095 = 10128
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_W0097 = 10129
    integer(kind=kint),parameter :: HECMW_IO_ABAQUS_W0099 = 10130
    integer(kind=kint),parameter :: HECMW_IO_E0001 = 10131
    integer(kind=kint),parameter :: HECMW_IO_E0002 = 10132
    integer(kind=kint),parameter :: HECMW_IO_E0003 = 10133
    integer(kind=kint),parameter :: HECMW_IO_E0004 = 10134
    integer(kind=kint),parameter :: HECMW_IO_E0005 = 10135
    integer(kind=kint),parameter :: HECMW_IO_E0006 = 10136
    integer(kind=kint),parameter :: HECMW_IO_E0007 = 10137
    integer(kind=kint),parameter :: HECMW_IO_E1012 = 10138
    integer(kind=kint),parameter :: HECMW_IO_E1013 = 10139
    integer(kind=kint),parameter :: HECMW_IO_E1014 = 10140
    integer(kind=kint),parameter :: HECMW_IO_E1015 = 10141
    integer(kind=kint),parameter :: HECMW_IO_E1018 = 10142
    integer(kind=kint),parameter :: HECMW_IO_E1021 = 10143
    integer(kind=kint),parameter :: HECMW_IO_E1022 = 10144
    integer(kind=kint),parameter :: HECMW_IO_E1023 = 10145
    integer(kind=kint),parameter :: HECMW_IO_E1024 = 10146
    integer(kind=kint),parameter :: HECMW_IO_E1025 = 10147
    integer(kind=kint),parameter :: HECMW_IO_E1026 = 10148
    integer(kind=kint),parameter :: HECMW_IO_E1027 = 10149
    integer(kind=kint),parameter :: HECMW_IO_E1028 = 10150
    integer(kind=kint),parameter :: HECMW_IO_E1029 = 10151
    integer(kind=kint),parameter :: HECMW_IO_E5001 = 10152
    integer(kind=kint),parameter :: HECMW_IO_E5002 = 10153
    integer(kind=kint),parameter :: HECMW_IO_E5003 = 10154
    integer(kind=kint),parameter :: HECMW_IO_E5004 = 10155
    integer(kind=kint),parameter :: HECMW_IO_E5005 = 10156
    integer(kind=kint),parameter :: HECMW_IO_E5006 = 10157
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0001 = 10158
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0002 = 10159
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0003 = 10160
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0004 = 10161
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0301 = 10162
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0302 = 10163
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0303 = 10164
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0311 = 10165
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0312 = 10166
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0313 = 10167
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0314 = 10168
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0321 = 10169
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0322 = 10170
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0323 = 10171
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0324 = 10172
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0331 = 10173
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0332 = 10174
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0341 = 10175
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0342 = 10176
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0343 = 10177
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0351 = 10178
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0352 = 10179
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0353 = 10180
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0361 = 10181
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0362 = 10182
    integer(kind=kint),parameter :: HECMW_IO_GEOFEM_E0363 = 10183
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0001 = 10184
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0002 = 10185
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0003 = 10186
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0098 = 10187
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0099 = 10188
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0100 = 10189
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0101 = 10190
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0200 = 10191
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0300 = 10192
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0400 = 10193
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0500 = 10194
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0501 = 10195
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0502 = 10196
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0503 = 10197
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0600 = 10198
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0601 = 10199
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0602 = 10200
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0603 = 10201
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0604 = 10202
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0605 = 10203
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0606 = 10204
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0700 = 10205
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0701 = 10206
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0702 = 10207
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0703 = 10208
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0800 = 10209
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0900 = 10210
    integer(kind=kint),parameter :: HECMW_IO_HEC_E0901 = 10211
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1000 = 10212
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1001 = 10213
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1002 = 10214
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1100 = 10215
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1101 = 10216
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1102 = 10217
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1103 = 10218
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1104 = 10219
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1105 = 10220
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1106 = 10221
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1107 = 10222
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1200 = 10223
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1300 = 10224
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1400 = 10225
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1500 = 10226
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1501 = 10227
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1502 = 10228
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1503 = 10229
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1600 = 10230
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1601 = 10231
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1700 = 10232
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1701 = 10233
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1702 = 10234
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1703 = 10235
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1704 = 10236
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1705 = 10237
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1706 = 10238
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1707 = 10239
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1708 = 10240
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1709 = 10241
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1710 = 10242
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1800 = 10243
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1801 = 10244
    integer(kind=kint),parameter :: HECMW_IO_HEC_E1900 = 10245
    integer(kind=kint),parameter :: HECMW_IO_HEC_E2000 = 10246
    integer(kind=kint),parameter :: HECMW_IO_HEC_E2100 = 10247
    integer(kind=kint),parameter :: HECMW_IO_HEC_E2101 = 10248
    integer(kind=kint),parameter :: HECMW_IO_W1001 = 10249
    integer(kind=kint),parameter :: HECMW_IO_W1002 = 10250
    integer(kind=kint),parameter :: HECMW_IO_W1003 = 10251
    integer(kind=kint),parameter :: HECMW_IO_W1004 = 10252
    integer(kind=kint),parameter :: HECMW_IO_W1005 = 10253
    integer(kind=kint),parameter :: HECMW_IO_W1006 = 10254
    integer(kind=kint),parameter :: HECMW_IO_W1007 = 10255
    integer(kind=kint),parameter :: HECMW_IO_W1008 = 10256
    integer(kind=kint),parameter :: HECMW_IO_W1009 = 10257
    integer(kind=kint),parameter :: HECMW_IO_W1010 = 10258
    integer(kind=kint),parameter :: HECMW_IO_W1011 = 10259
    integer(kind=kint),parameter :: HECMW_IO_W1016 = 10260
    integer(kind=kint),parameter :: HECMW_IO_W1017 = 10261
    integer(kind=kint),parameter :: HECMW_IO_W1019 = 10262
    integer(kind=kint),parameter :: HECMW_IO_W1020 = 10263
    integer(kind=kint),parameter :: HECMW_IO_W1021 = 10362
    integer(kind=kint),parameter :: HECMW_PART_E0001 = 10264
    integer(kind=kint),parameter :: HECMW_PART_E0002 = 10265
    integer(kind=kint),parameter :: HECMW_PART_E0003 = 10266
    integer(kind=kint),parameter :: HECMW_PART_E0004 = 10267
    integer(kind=kint),parameter :: HECMW_PART_E0005 = 10268
    integer(kind=kint),parameter :: HECMW_PART_E0006 = 10269
    integer(kind=kint),parameter :: HECMW_PART_E0101 = 10270
    integer(kind=kint),parameter :: HECMW_PART_E0111 = 10271
    integer(kind=kint),parameter :: HECMW_PART_E0112 = 10272
    integer(kind=kint),parameter :: HECMW_PART_E0113 = 10273
    integer(kind=kint),parameter :: HECMW_PART_E0121 = 10274
    integer(kind=kint),parameter :: HECMW_PART_E0122 = 10275
    integer(kind=kint),parameter :: HECMW_PART_E0123 = 10276
    integer(kind=kint),parameter :: HECMW_PART_E0124 = 10277
    integer(kind=kint),parameter :: HECMW_PART_E0125 = 10278
    integer(kind=kint),parameter :: HECMW_PART_E0131 = 10279
    integer(kind=kint),parameter :: HECMW_PART_E0132 = 10280
    integer(kind=kint),parameter :: HECMW_PART_E0133 = 10281
    integer(kind=kint),parameter :: HECMW_PART_E0134 = 10282
    integer(kind=kint),parameter :: HECMW_PART_E0141 = 10283
    integer(kind=kint),parameter :: HECMW_PART_E0142 = 10284
    integer(kind=kint),parameter :: HECMW_PART_E0151 = 10285
    integer(kind=kint),parameter :: HECMW_PART_E0152 = 10286
    integer(kind=kint),parameter :: HECMW_PART_E0153 = 10287
    integer(kind=kint),parameter :: HECMW_PART_E0154 = 10288
    integer(kind=kint),parameter :: HECMW_PART_E0161 = 10289
    integer(kind=kint),parameter :: HECMW_PART_E0162 = 10290
    integer(kind=kint),parameter :: HECMW_PART_E0164 = 10291
    integer(kind=kint),parameter :: HECMW_PART_E0201 = 10292
    integer(kind=kint),parameter :: HECMW_PART_E0202 = 10293
    integer(kind=kint),parameter :: HECMW_PART_E0203 = 10294
    integer(kind=kint),parameter :: HECMW_PART_E0204 = 10295
    integer(kind=kint),parameter :: HECMW_PART_E0205 = 10296
    integer(kind=kint),parameter :: HECMW_PART_E0206 = 10297
    integer(kind=kint),parameter :: HECMW_PART_E0211 = 10298
    integer(kind=kint),parameter :: HECMW_PART_E0301 = 10299
    integer(kind=kint),parameter :: HECMW_PART_E0302 = 10300
    integer(kind=kint),parameter :: HECMW_PART_E0311 = 10301
    integer(kind=kint),parameter :: HECMW_PART_E0312 = 10302
    integer(kind=kint),parameter :: HECMW_PART_E0313 = 10303
    integer(kind=kint),parameter :: HECMW_PART_E0321 = 10304
    integer(kind=kint),parameter :: HECMW_PART_E0322 = 10305
    integer(kind=kint),parameter :: HECMW_PART_E0323 = 10306
    integer(kind=kint),parameter :: HECMW_PART_E0331 = 10307
    integer(kind=kint),parameter :: HECMW_PART_E0501 = 10308
    integer(kind=kint),parameter :: HECMW_PART_W0163 = 10309
    integer(kind=kint),parameter :: HECMW_PART_W0165 = 10310
    integer(kind=kint),parameter :: HECMW_PART_W0401 = 10311
    integer(kind=kint),parameter :: HECMW_PART_W0502 = 10312
    integer(kind=kint),parameter :: HECMW_UTIL_E0001 = 10313
    integer(kind=kint),parameter :: HECMW_UTIL_E0002 = 10314
    integer(kind=kint),parameter :: HECMW_UTIL_E0003 = 10315
    integer(kind=kint),parameter :: HECMW_UTIL_E0004 = 10316
    integer(kind=kint),parameter :: HECMW_UTIL_E0005 = 10317
    integer(kind=kint),parameter :: HECMW_UTIL_E0010 = 10318
    integer(kind=kint),parameter :: HECMW_UTIL_E0011 = 10319
    integer(kind=kint),parameter :: HECMW_UTIL_E0012 = 10320
    integer(kind=kint),parameter :: HECMW_UTIL_E0013 = 10321
    integer(kind=kint),parameter :: HECMW_UTIL_E0014 = 10322
    integer(kind=kint),parameter :: HECMW_UTIL_E0020 = 10323
    integer(kind=kint),parameter :: HECMW_UTIL_E0021 = 10324
    integer(kind=kint),parameter :: HECMW_UTIL_E0022 = 10325
    integer(kind=kint),parameter :: HECMW_UTIL_E0023 = 10326
    integer(kind=kint),parameter :: HECMW_UTIL_E0024 = 10327
    integer(kind=kint),parameter :: HECMW_UTIL_E0025 = 10328
    integer(kind=kint),parameter :: HECMW_UTIL_E0030 = 10329
    integer(kind=kint),parameter :: HECMW_UTIL_E0031 = 10330
    integer(kind=kint),parameter :: HECMW_UTIL_E0032 = 10331
    integer(kind=kint),parameter :: HECMW_UTIL_E0033 = 10332
    integer(kind=kint),parameter :: HECMW_UTIL_E0040 = 10333
    integer(kind=kint),parameter :: HECMW_UTIL_E0041 = 10334
    integer(kind=kint),parameter :: HECMW_UTIL_E0042 = 10335
    integer(kind=kint),parameter :: HECMW_UTIL_E0043 = 10336
    integer(kind=kint),parameter :: HECMW_UTIL_E0044 = 10337
    integer(kind=kint),parameter :: HECMW_UTIL_E0045 = 10338
    integer(kind=kint),parameter :: HECMW_UTIL_E0050 = 10339
    integer(kind=kint),parameter :: HECMW_UTIL_E0051 = 10340
    integer(kind=kint),parameter :: HECMW_UTIL_E0052 = 10341
    integer(kind=kint),parameter :: HECMW_UTIL_E0053 = 10342
    integer(kind=kint),parameter :: HECMW_UTIL_E0054 = 10343
    integer(kind=kint),parameter :: HECMW_UTIL_E0055 = 10344
    integer(kind=kint),parameter :: HECMW_UTIL_E0060 = 10345
    integer(kind=kint),parameter :: HECMW_UTIL_E0061 = 10346
    integer(kind=kint),parameter :: HECMW_UTIL_E0101 = 10347
    integer(kind=kint),parameter :: HECMW_UTIL_E0102 = 10348
    integer(kind=kint),parameter :: HECMW_UTIL_E0103 = 10349
    integer(kind=kint),parameter :: HECMW_UTIL_E0104 = 10350
    integer(kind=kint),parameter :: HECMW_UTIL_E0105 = 10351
    integer(kind=kint),parameter :: HECMW_UTIL_E0201 = 10352
    integer(kind=kint),parameter :: HECMW_UTIL_E0202 = 10353
    integer(kind=kint),parameter :: HECMW_UTIL_E0203 = 10354
    integer(kind=kint),parameter :: HECMW_UTIL_E0204 = 10355
    integer(kind=kint),parameter :: HECMW_UTIL_E0205 = 10356
    integer(kind=kint),parameter :: HECMW_UTIL_E0206 = 10357
    integer(kind=kint),parameter :: HECMW_UTIL_E0207 = 10358
    integer(kind=kint),parameter :: HECMW_UTIL_E9001 = 10359
    integer(kind=kint),parameter :: HECMW_UTIL_E9011 = 10360
    integer(kind=kint),parameter :: HECMW_UTIL_E9012 = 10361
    integer(kind=kint),parameter :: HECMW_UTIL_E9013 = 10363

end module hecmw_msgno
