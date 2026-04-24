# ##############################################  Core  ##############################################
set_location_assignment	PIN_E16	-to	CLK

set_location_assignment	PIN_B16	-to	RESET

#LED
set_location_assignment	PIN_D12	-to	LED[0]
set_location_assignment	PIN_C11	-to	LED[1]
set_location_assignment	PIN_B10	-to	LED[2]
set_location_assignment	PIN_B7		-to	LED[3]


#SDRAM
set_location_assignment	PIN_P8	-to	RA[0]
set_location_assignment	PIN_P6	-to	RA[1]
set_location_assignment	PIN_L6	-to	RA[2]
set_location_assignment	PIN_N8	-to	RA[3]
set_location_assignment	PIN_R12	-to	RA[4]
set_location_assignment	PIN_T12	-to	RA[5]
set_location_assignment	PIN_R13	-to	RA[6]
set_location_assignment	PIN_T13	-to	RA[7]
set_location_assignment	PIN_R14	-to	RA[8]
set_location_assignment	PIN_T14	-to	RA[9]
set_location_assignment	PIN_N5	-to	RA[10]
set_location_assignment	PIN_R16	-to	RA[11]
set_location_assignment	PIN_T15	-to	RA[12]

set_location_assignment	PIN_K2	-to	DQ[0]
set_location_assignment	PIN_K1	-to	DQ[1]
set_location_assignment	PIN_L2	-to	DQ[2]
set_location_assignment	PIN_L1	-to	DQ[3]
set_location_assignment	PIN_N2	-to	DQ[4]
set_location_assignment	PIN_N1	-to	DQ[5]
set_location_assignment	PIN_P2	-to	DQ[6]
set_location_assignment	PIN_P1	-to	DQ[7]
set_location_assignment	PIN_N15	-to	DQ[8]
set_location_assignment	PIN_L16	-to	DQ[9]
set_location_assignment	PIN_L15	-to	DQ[10]
set_location_assignment	PIN_K16	-to	DQ[11]
set_location_assignment	PIN_K15	-to	DQ[12]
set_location_assignment	PIN_J16	-to	DQ[13]
set_location_assignment	PIN_J15	-to	DQ[14]
set_location_assignment	PIN_G15	-to	DQ[15]

set_location_assignment	PIN_P15	-to	S_CLK
#UDQM
set_location_assignment	PIN_N16	-to	S_DQM[1]
#LDQM
set_location_assignment	PIN_T2	-to	S_DQM[0]
set_location_assignment	PIN_N6	-to	BA[1]
set_location_assignment	PIN_N3	-to	BA[0]

set_location_assignment	PIN_P3	-to	CS
set_location_assignment	PIN_L4	-to	CAS
set_location_assignment	PIN_L3	-to	RAS
set_location_assignment	PIN_R1	-to	WE
set_location_assignment	PIN_P16	-to	CKE


#LCD12864
set_location_assignment	PIN_G16	-to	RS
set_location_assignment	PIN_F16	-to	R/W
set_location_assignment	PIN_F15	-to	E
set_location_assignment	PIN_L10	-to	D0
set_location_assignment	PIN_M10	-to	D1
set_location_assignment	PIN_M11	-to	D2
set_location_assignment	PIN_N13	-to	D3
set_location_assignment	PIN_P14	-to	D4
set_location_assignment	PIN_N14	-to	D5
set_location_assignment	PIN_L13	-to	D6
set_location_assignment	PIN_M12	-to	D7
set_location_assignment	PIN_L12	-to	PSB

set_location_assignment	PIN_J13	-to	RST

set_location_assignment	PIN_K12	-to	A ;# LCD_P
set_location_assignment	PIN_J12	-to	K ;# LCD_N

#LCD1602
set_location_assignment	PIN_G16	-to	RS
set_location_assignment	PIN_F16	-to	R/W
set_location_assignment	PIN_F15	-to	E
set_location_assignment	PIN_L10	-to	D0
set_location_assignment	PIN_M10	-to	D1
set_location_assignment	PIN_M11	-to	D2
set_location_assignment	PIN_N13	-to	D3
set_location_assignment	PIN_P14	-to	D4
set_location_assignment	PIN_N14	-to	D5
set_location_assignment	PIN_L13	-to	D6
set_location_assignment	PIN_M12	-to	D7
set_location_assignment	PIN_L12	-to	A ;# LCD_P
set_location_assignment	PIN_L14	-to	K ;# LCD_N


#8I/Os_1
set_location_assignment	PIN_J13	-to	8I/Os_1_8
set_location_assignment	PIN_L11	-to	8I/Os_1_7
set_location_assignment	PIN_K12	-to	8I/Os_1_6
set_location_assignment	PIN_J12	-to	8I/Os_1_5
set_location_assignment	PIN_K11	-to	8I/Os_1_4
set_location_assignment	PIN_J11	-to	8I/Os_1_3
set_location_assignment	PIN_K10	-to	8I/Os_1_2
set_location_assignment	PIN_F11	-to	8I/Os_1_1
#8I/Os_2
set_location_assignment	PIN_G1	-to	8I/Os_2_8
set_location_assignment	PIN_G2	-to	8I/Os_2_7
set_location_assignment	PIN_J1	-to	8I/Os_2_6
set_location_assignment	PIN_J2	-to	8I/Os_2_5
set_location_assignment	PIN_K1	-to	8I/Os_2_4
set_location_assignment	PIN_K2	-to	8I/Os_2_3
set_location_assignment	PIN_L1	-to	8I/Os_2_2
set_location_assignment	PIN_L2	-to	8I/Os_2_1
#16I/Os_1
set_location_assignment	PIN_L6	-to	16I/Os_1_1
set_location_assignment	PIN_N8	-to	16I/Os_1_2
set_location_assignment	PIN_P8	-to	16I/Os_1_3
set_location_assignment	PIN_P6	-to	16I/Os_1_4
set_location_assignment	PIN_N6	-to	16I/Os_1_5
set_location_assignment	PIN_N5	-to	16I/Os_1_6
set_location_assignment	PIN_P3	-to	16I/Os_1_7
set_location_assignment	PIN_N3	-to	16I/Os_1_8
set_location_assignment	PIN_L4	-to	16I/Os_1_9
set_location_assignment	PIN_L3	-to	16I/Os_1_10
set_location_assignment	PIN_T2	-to	16I/Os_1_11
set_location_assignment	PIN_R1	-to	16I/Os_1_12
set_location_assignment	PIN_P2	-to	16I/Os_1_13
set_location_assignment	PIN_P1	-to	16I/Os_1_14
set_location_assignment	PIN_N2	-to	16I/Os_1_15
set_location_assignment	PIN_N1	-to	16I/Os_1_16

#16I/Os_2
set_location_assignment	PIN_F2	-to	16I/Os_2_1
set_location_assignment	PIN_F1	-to	16I/Os_2_2
set_location_assignment	PIN_D1	-to	16I/Os_2_3
set_location_assignment	PIN_C2	-to	16I/Os_2_4
set_location_assignment	PIN_B1	-to	16I/Os_2_5
set_location_assignment	PIN_A2	-to	16I/Os_2_6
set_location_assignment	PIN_B3	-to	16I/Os_2_7
set_location_assignment	PIN_A3	-to	16I/Os_2_8
set_location_assignment	PIN_B4	-to	16I/Os_2_9
set_location_assignment	PIN_A4	-to	16I/Os_2_10
set_location_assignment	PIN_B5	-to	16I/Os_2_11
set_location_assignment	PIN_A5	-to	16I/Os_2_12
set_location_assignment	PIN_B6	-to	16I/Os_2_13
set_location_assignment	PIN_A6	-to	16I/Os_2_14
set_location_assignment	PIN_F3	-to	16I/Os_2_15
set_location_assignment	PIN_D3	-to	16I/Os_2_16

#32I/Os_1
set_location_assignment	PIN_L12	-to	32I/Os_1_1
set_location_assignment	PIN_L14	-to	32I/Os_1_2
set_location_assignment	PIN_L13	-to	32I/Os_1_3
set_location_assignment	PIN_M12	-to	32I/Os_1_4
set_location_assignment	PIN_P14	-to	32I/Os_1_5
set_location_assignment	PIN_N14	-to	32I/Os_1_6
set_location_assignment	PIN_M11	-to	32I/Os_1_7
set_location_assignment	PIN_N13	-to	32I/Os_1_8
set_location_assignment	PIN_L10	-to	32I/Os_1_9
set_location_assignment	PIN_M10	-to	32I/Os_1_10
set_location_assignment	PIN_F16	-to	32I/Os_1_11
set_location_assignment	PIN_F15	-to	32I/Os_1_12
set_location_assignment	PIN_G16	-to	32I/Os_1_13
set_location_assignment	PIN_G15	-to	32I/Os_1_14
set_location_assignment	PIN_J15	-to	32I/Os_1_15
set_location_assignment	PIN_J16	-to	32I/Os_1_16
set_location_assignment	PIN_K15	-to	32I/Os_1_17
set_location_assignment	PIN_K16	-to	32I/Os_1_18
set_location_assignment	PIN_L15	-to	32I/Os_1_19
set_location_assignment	PIN_L16	-to	32I/Os_1_20
set_location_assignment	PIN_N15	-to	32I/Os_1_21
set_location_assignment	PIN_N16	-to	32I/Os_1_22
set_location_assignment	PIN_P15	-to	32I/Os_1_23
set_location_assignment	PIN_P16	-to	32I/Os_1_24
set_location_assignment	PIN_T15	-to	32I/Os_1_25
set_location_assignment	PIN_R16	-to	32I/Os_1_26
set_location_assignment	PIN_T14	-to	32I/Os_1_27
set_location_assignment	PIN_R14	-to	32I/Os_1_28
set_location_assignment	PIN_T13	-to	32I/Os_1_29
set_location_assignment	PIN_R13	-to	32I/Os_1_30
set_location_assignment	PIN_T12	-to	32I/Os_1_31
set_location_assignment	PIN_R12	-to	32I/Os_1_32

#32I/Os_2
set_location_assignment	PIN_R11	-to	32I/Os_2_1
set_location_assignment	PIN_N12	-to	32I/Os_2_2
set_location_assignment	PIN_P11	-to	32I/Os_2_3
set_location_assignment	PIN_N11	-to	32I/Os_2_4
set_location_assignment	PIN_P9	-to	32I/Os_2_5
set_location_assignment	PIN_N9	-to	32I/Os_2_6
set_location_assignment	PIN_R10	-to	32I/Os_2_7
set_location_assignment	PIN_T11	-to	32I/Os_2_8
set_location_assignment	PIN_R9	-to	32I/Os_2_9
set_location_assignment	PIN_T10	-to	32I/Os_2_10
set_location_assignment	PIN_R8	-to	32I/Os_2_11
set_location_assignment	PIN_T9	-to	32I/Os_2_12
set_location_assignment	PIN_R7	-to	32I/Os_2_13
set_location_assignment	PIN_T8	-to	32I/Os_2_14
set_location_assignment	PIN_R6	-to	32I/Os_2_15
set_location_assignment	PIN_T7	-to	32I/Os_2_16
set_location_assignment	PIN_R5	-to	32I/Os_2_17
set_location_assignment	PIN_T6	-to	32I/Os_2_18
set_location_assignment	PIN_R4	-to	32I/Os_2_19
set_location_assignment	PIN_T5	-to	32I/Os_2_20
set_location_assignment	PIN_R3	-to	32I/Os_2_21
set_location_assignment	PIN_T4	-to	32I/Os_2_22
set_location_assignment	PIN_M9	-to	32I/Os_2_23
set_location_assignment	PIN_T3	-to	32I/Os_2_24
set_location_assignment	PIN_K9	-to	32I/Os_2_25
set_location_assignment	PIN_L9	-to	32I/Os_2_26
set_location_assignment	PIN_L8	-to	32I/Os_2_27
set_location_assignment	PIN_K8	-to	32I/Os_2_28
set_location_assignment	PIN_M7	-to	32I/Os_2_29
set_location_assignment	PIN_M8	-to	32I/Os_2_30
set_location_assignment	PIN_M6	-to	32I/Os_2_31
set_location_assignment	PIN_L7	-to	32I/Os_2_32

#32I/Os_3
set_location_assignment	PIN_A7	-to	32I/Os_3_1
set_location_assignment	PIN_E6	-to	32I/Os_3_2
set_location_assignment	PIN_B8	-to	32I/Os_3_3
set_location_assignment	PIN_A8	-to	32I/Os_3_4
set_location_assignment	PIN_B9	-to	32I/Os_3_5
set_location_assignment	PIN_A9	-to	32I/Os_3_6
set_location_assignment	PIN_D5	-to	32I/Os_3_7
set_location_assignment	PIN_C6	-to	32I/Os_3_8
set_location_assignment	PIN_D6	-to	32I/Os_3_9
set_location_assignment	PIN_E7	-to	32I/Os_3_10
set_location_assignment	PIN_E8	-to	32I/Os_3_11
set_location_assignment	PIN_F8	-to	32I/Os_3_12
set_location_assignment	PIN_G11	-to	32I/Os_3_13
set_location_assignment	PIN_F9	-to	32I/Os_3_14
set_location_assignment	PIN_E9	-to	32I/Os_3_15
set_location_assignment	PIN_E10	-to	32I/Os_3_16
set_location_assignment	PIN_D8	-to	32I/Os_3_17
set_location_assignment	PIN_C8	-to	32I/Os_3_18
set_location_assignment	PIN_D9	-to	32I/Os_3_19
set_location_assignment	PIN_C9	-to	32I/Os_3_20
set_location_assignment	PIN_B11	-to	32I/Os_3_21
set_location_assignment	PIN_A10	-to	32I/Os_3_22
set_location_assignment	PIN_A12	-to	32I/Os_3_23
set_location_assignment	PIN_A11	-to	32I/Os_3_24
set_location_assignment	PIN_A13	-to	32I/Os_3_25
set_location_assignment	PIN_B12	-to	32I/Os_3_26
set_location_assignment	PIN_A14	-to	32I/Os_3_27
set_location_assignment	PIN_B13	-to	32I/Os_3_28
set_location_assignment	PIN_E11	-to	32I/Os_3_29
set_location_assignment	PIN_F10	-to	32I/Os_3_30
set_location_assignment	PIN_B14	-to	32I/Os_3_31
set_location_assignment	PIN_D11	-to	32I/Os_3_32
