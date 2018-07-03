* = $801
_basic_loader.array
    !byte $B, 8, $A, 0, $9E, $32, $30, $36, $31, 0, 0, 0
* = $80d
main
    LDA #$FF
    STA $D40E
    STA $D40F
    LDA #$80
    STA $D412
.ai__00352.wh__00033
    LDA $D012
    CMP #$70
    BNE .ai__00352.wh__00033
    LDA $D41B
    STA rand_seed + 1
.ai__00352.wh__00038
    LDA $D012
    CMP #$40
    BNE .ai__00352.wh__00038
    LDA $D41B
    STA rand_seed
    LDA #0
    STA hi_score
    STA hi_score + 1
    STA hi_score + 2
    STA hi_score + 3
    SEI 
    LDA #$33
    STA 1
    LDX #0
looptyloop
    LDA $D000, X
    STA $B800, X
    LDA $D100, X
    STA $B900, X
    INX 
    BNE looptyloop
    LDA #$36
    STA 1
    CLI 
    LDY #$80
.do__00336
    DEY 
    LDA #0
    STA $BB00, Y
    TYA 
    BNE .do__00336
    LDA #1
    STA $BB00
    LDY #$28
.do__00339
    DEY 
    LDA fuel_bar.array, Y
    STA $B8D8, Y
    TYA 
    BNE .do__00339
    JSR build_sprite_freezing_charset
    LDA #3
    STA $DD02
    LDA #1
    STA $DD00
    LDA #$DE
    STA $D018
    LDA #0
    STA $D020
    STA $D015
    LDA #$FF
    STA $D01C
    LDA #$F
    STA $D025
    LDA #$B
    STA $D021
    LDA #1
    STA $D026
    STA $D023
    LDA $D016
    ORA #$10
    STA $D016
    LDY #$A0
.ai__00353.do__00255
    DEY 
    LDA sprite_bike_data.array, Y
    STA standard_sprites + $40, Y
    LDA sprite_bike_data.array + $A0, Y
    STA standard_sprites + $E0, Y
    TYA 
    BNE .ai__00353.do__00255
.wh__00344
    JSR show_title_screen
    JSR init_game
    LDA #0
    STA restart_game
    BEQ .he__00349
.wh__00348
    JSR update_screen
.ai__00354.wh__00247
    LDA $D012
    CMP #$FF
    BNE .ai__00354.wh__00247
    LDA sound_countdown
    CMP #$7F
    BEQ .ai__00355.fi__00260
    LDA sound_countdown
    BEQ .ai__00355.el__00258
    DEC sound_countdown
    JMP .ai__00355.fi__00259
.ai__00355.el__00258
    LDA sound_pointer
    STA run_sound_command$p
    LDA sound_pointer + 1
    STA run_sound_command$p + 1
    JSR run_sound_command
    STX sound_countdown
    CLC 
    ADC sound_pointer
    STA sound_pointer
    BCC .ai__00355.ah__30007
    INC sound_pointer + 1
.ai__00355.ah__30007
.ai__00355.fi__00259
.ai__00355.fi__00260
.he__00349
    LDA restart_game
    BEQ .wh__00348
    BNE .wh__00344
* = $912
spawn_object
    LDY #1
    BNE .he__00210
.wh__00209
    LDA o_types.array, Y
    BNE .fi__00214
    LDA spawn_object$type
    STA o_types.array, Y
    LDA #$4A
    STA o_position_lo.array, Y
    LDA #1
    STA o_position_hi.array, Y
    LDA spawn_object$lane
    STA o_lane.array, Y
    LDA #0
    STA o_flying_y.array, Y
    BIT spawn_object$type
    BPL .fi__00213
    TYA 
    CLC 
    ADC #card_sprites >> 6.lo
    STA draw_card_to_sprite$sprite_pointer
    LDA spawn_object$type
    STA draw_card_to_sprite$card
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    JMP draw_card_to_sprite
.fi__00213
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
.fi__00214
    INY 
.he__00210
    CPY #8
    BCC .wh__00209
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $94e
display_hi_score
    LDA #6
    STA hi_put_dec_byte$at
    LDA hi_score
    STA hi_put_dec_byte$b
    JSR hi_put_dec_byte
    LDA #4
    STA hi_put_dec_byte$at
    LDA hi_score + 1
    STA hi_put_dec_byte$b
    JSR hi_put_dec_byte
    LDA #2
    STA hi_put_dec_byte$at
    LDA hi_score + 2
    STA hi_put_dec_byte$b
    JSR hi_put_dec_byte
    LDA #0
    STA hi_put_dec_byte$at
    LDA hi_score + 3
    STA hi_put_dec_byte$b
    JMP hi_put_dec_byte
* = $986
draw_card_to_screen
    ASL draw_card_to_screen$position
    ASL draw_card_to_screen$position
    LDA #$F0
    LDY draw_card_to_screen$position
    STA screen + $29, Y
    LDA #$F1
    STA screen + $2A, Y
    LDA #$F2
    STA screen + $2B, Y
    LDA #$F4
    STA screen + $F1, Y
    LDA #$F5
    STA screen + $F2, Y
    LDA #$F6
    STA screen + $F3, Y
    LDA draw_card_to_screen$card
    AND #$3C
    ASL 
    ORA #$80
    TAX 
    STA screen + $51, Y
    ORA #1
    STA screen + $52, Y
    TXA 
    ORA #2
    STA screen + $53, Y
    TXA 
    ORA #4
    STA screen + $79, Y
    TXA 
    ORA #5
    STA screen + $7A, Y
    TXA 
    ORA #6
    STA screen + $7B, Y
    LDA draw_card_to_screen$card
    AND #3
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    ORA #$83
    TAX 
    STA screen + $A1, Y
    ORA #4
    STA screen + $A2, Y
    TXA 
    ORA #8
    STA screen + $A3, Y
    TXA 
    ORA #$10
    STA screen + $C9, Y
    TXA 
    ORA #$14
    STA screen + $CA, Y
    TXA 
    ORA #$18
    STA screen + $CB, Y
    LDA draw_card_to_screen$card
    AND #1
    ASL 
    ORA #8
    STA $D829, Y
    STA $D82A, Y
    STA $D82B, Y
    STA $D851, Y
    STA $D852, Y
    STA $D853, Y
    STA $D879, Y
    STA $D87A, Y
    STA $D87B, Y
    STA $D8A1, Y
    STA $D8A2, Y
    STA $D8A3, Y
    STA $D8C9, Y
    STA $D8CA, Y
    STA $D8CB, Y
    STA $D8F1, Y
    STA $D8F2, Y
    STA $D8F3, Y
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $a3c
build_sprite_freezing_charset
    LDA #charset + $780.lo
    STA build_sprite_freezing_charset$target
    LDA #charset + $780.hi
    STA build_sprite_freezing_charset$target + 1
    LDA #0
    STA build_sprite_freezing_charset$i
    BEQ .he__00301
.wh__00300
    LDA #0
    LDX build_sprite_freezing_charset$i
    STA $BF80, X
    INC build_sprite_freezing_charset$i
.he__00301
    LDA build_sprite_freezing_charset$i
    CMP #$40
    BCC .wh__00300
    LDA #$D5
    STA $BF86
    STA $BF87
    LDA #$55
    STA $BF8E
    STA $BF8F
    LDA #$57
    STA $BF96
    STA $BF97
    LDA #$D5
    STA $BFA0
    STA $BFA1
    LDA #$55
    STA $BFA8
    STA $BFA9
    LDA #$57
    STA $BFB0
    STA $BFB1
    LDA #$3F
    STA $BF84
    STA $BF85
    LDA #$FF
    STA $BF8C
    STA $BF8D
    LDA #$FC
    STA $BF94
    STA $BF95
    LDA #$3F
    STA $BFA2
    STA $BFA3
    LDA #$FF
    STA $BFAA
    STA $BFAB
    LDA #$FC
    STA $BFB2
    STA $BFB3
    LDA #2
    STA build_sprite_freezing_charset$j
.do__00304
    DEC build_sprite_freezing_charset$j
    LDA #charset + $400.lo
    STA build_sprite_freezing_charset$target
    LDA #charset + $400.hi
    STA build_sprite_freezing_charset$target + 1
    LDA build_sprite_freezing_charset$j
    BEQ .fi__00307
    INC build_sprite_freezing_charset$target
.fi__00307
    LDA #sprite_rank_data.lo
    STA build_sprite_freezing_charset$source
    LDA #sprite_rank_data.hi
    STA build_sprite_freezing_charset$source + 1
    LDA #0
    STA build_sprite_freezing_charset$i
    BEQ .he__00309
.wh__00308
    LDA #$C
    STA build_sprite_freezing_charset$b
.do__00312
    DEC build_sprite_freezing_charset$b
    LDY build_sprite_freezing_charset$b
    LDA (build_sprite_freezing_charset$source), Y
    EOR #$55
    LDX build_sprite_freezing_charset$b
    LDY char_offsets.array, X
    STA (build_sprite_freezing_charset$target), Y
    LDA build_sprite_freezing_charset$b
    BNE .do__00312
    CLC 
    LDA build_sprite_freezing_charset$target
    ADC #$20
    STA build_sprite_freezing_charset$target
    BCC .ah__30009
    INC build_sprite_freezing_charset$target + 1
.ah__30009
    CLC 
    LDA build_sprite_freezing_charset$source
    ADC #$C
    STA build_sprite_freezing_charset$source
    BCC .ah__30010
    INC build_sprite_freezing_charset$source + 1
.ah__30010
    LDA #$C
    STA build_sprite_freezing_charset$b
.do__00315
    DEC build_sprite_freezing_charset$b
    LDY build_sprite_freezing_charset$b
    LDA (build_sprite_freezing_charset$source), Y
    EOR #$55
    LDX build_sprite_freezing_charset$b
    LDY char_offsets.array, X
    STA (build_sprite_freezing_charset$target), Y
    LDA build_sprite_freezing_charset$b
    BNE .do__00315
    CLC 
    LDA build_sprite_freezing_charset$target
    ADC #$20
    STA build_sprite_freezing_charset$target
    BCC .ah__30011
    INC build_sprite_freezing_charset$target + 1
.ah__30011
    CLC 
    LDA build_sprite_freezing_charset$source
    ADC #$C
    STA build_sprite_freezing_charset$source
    BCC .ah__30012
    INC build_sprite_freezing_charset$source + 1
.ah__30012
    INC build_sprite_freezing_charset$i
.he__00309
    LDA build_sprite_freezing_charset$i
    CMP #$D
    BCC .wh__00308
    LDA build_sprite_freezing_charset$j
    BEQ .lj80004
    JMP .do__00304
.lj80004
    LDA #2
    STA build_sprite_freezing_charset$j
.do__00318
    DEC build_sprite_freezing_charset$j
    LDA #charset + $418.lo
    STA build_sprite_freezing_charset$target
    LDA #charset + $418.hi
    STA build_sprite_freezing_charset$target + 1
    LDA build_sprite_freezing_charset$j
    BEQ .fi__00321
    INC build_sprite_freezing_charset$target
.fi__00321
    LDA #sprite_suit_data.lo
    STA build_sprite_freezing_charset$source
    LDA #sprite_suit_data.hi
    STA build_sprite_freezing_charset$source + 1
    LDA #0
    STA build_sprite_freezing_charset$i
    BEQ .he__00323
.wh__00322
    LDA #$C
    STA build_sprite_freezing_charset$b
.do__00326
    DEC build_sprite_freezing_charset$b
    LDY build_sprite_freezing_charset$b
    LDA (build_sprite_freezing_charset$source), Y
    EOR #$55
    LDX build_sprite_freezing_charset$b
    LDY char_offsets2.array, X
    STA (build_sprite_freezing_charset$target), Y
    LDA build_sprite_freezing_charset$b
    BNE .do__00326
    CLC 
    LDA build_sprite_freezing_charset$target
    ADC #$80
    STA build_sprite_freezing_charset$target
    BCC .ah__30013
    INC build_sprite_freezing_charset$target + 1
.ah__30013
    CLC 
    LDA build_sprite_freezing_charset$source
    ADC #$C
    STA build_sprite_freezing_charset$source
    BCC .ah__30014
    INC build_sprite_freezing_charset$source + 1
.ah__30014
    LDA #$C
    STA build_sprite_freezing_charset$b
.do__00329
    DEC build_sprite_freezing_charset$b
    LDY build_sprite_freezing_charset$b
    LDA (build_sprite_freezing_charset$source), Y
    EOR #$55
    LDX build_sprite_freezing_charset$b
    LDY char_offsets2.array, X
    STA (build_sprite_freezing_charset$target), Y
    LDA build_sprite_freezing_charset$b
    BNE .do__00329
    CLC 
    LDA build_sprite_freezing_charset$target
    ADC #$80
    STA build_sprite_freezing_charset$target
    BCC .ah__30015
    INC build_sprite_freezing_charset$target + 1
.ah__30015
    CLC 
    LDA build_sprite_freezing_charset$source
    ADC #$C
    STA build_sprite_freezing_charset$source
    BCC .ah__30016
    INC build_sprite_freezing_charset$source + 1
.ah__30016
    INC build_sprite_freezing_charset$i
.he__00323
    LDA build_sprite_freezing_charset$i
    CMP #4
    BCC .wh__00322
    LDA build_sprite_freezing_charset$j
    BEQ .lj80005
    JMP .do__00318
.lj80005
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $bd0
run_sound_command
    LDA #0
    STA run_sound_command$delta
    BEQ .he__00244
.wh__00243
    LDY run_sound_command$delta
    INY 
    LDA (run_sound_command$p), Y
    PHA 
    LDY run_sound_command$delta
    LDA (run_sound_command$p), Y
    TAX 
    PLA 
    STA $D400, X
    LDX run_sound_command$delta
    INX 
    INX 
    STX run_sound_command$delta
.he__00244
    LDY run_sound_command$delta
    LDA (run_sound_command$p), Y
    BPL .wh__00243
    LDA run_sound_command$delta
    CLC 
    ADC #1
    PHA 
    LDY run_sound_command$delta
    LDA (run_sound_command$p), Y
    AND #$7F
    TAX 
    PLA 
    ; DISCARD_YF
    RTS 
* = $c00
calculate_sprites
    LDA #8
    STA calculate_sprites$i
.do__00120
    DEC calculate_sprites$i
    LDA #$FF
    LDY calculate_sprites$i
    STA sprite_to_obj.array, Y
    STA obj_to_sprite.array, Y
    TYA 
    BNE .do__00120
    LDA #0
    STA calculate_sprites$next
    LDA #3
    STA calculate_sprites$l
.do__00123
    DEC calculate_sprites$l
    LDA #0
    STA calculate_sprites$i
    BEQ .he__00127
.wh__00126
    LDY calculate_sprites$i
    LDA o_types.array, Y
    BEQ .fi__00130
    LDY calculate_sprites$i
    LDA o_lane.array, Y
    CMP calculate_sprites$l
    BNE .fi__00130
    LDA calculate_sprites$next
    LDY calculate_sprites$i
    STA obj_to_sprite.array, Y
    TYA 
    LDY calculate_sprites$next
    STA sprite_to_obj.array, Y
    INC calculate_sprites$next
.fi__00130
    INC calculate_sprites$i
.he__00127
    LDA calculate_sprites$i
    CMP #8
    BCC .wh__00126
    LDA calculate_sprites$l
    BNE .do__00123
    LDA #1
    STA calculate_sprites$mask
    LDA #0
    STA $D01D
    STA $D017
    STA $D015
    STA $D010
    STA calculate_sprites$s
.wh__00131
    LDA calculate_sprites$s
    CMP #8
    BCC .he__00132
    JMP .ew__00134
.he__00132
    LDY calculate_sprites$s
    LDA sprite_to_obj.array, Y
    STA calculate_sprites$i
    AND #$80
    BNE .an__00152
    LDY calculate_sprites$i
    LDA o_types.array, Y
    BNE .th__00150
.an__00152
    JMP .fi__00151
.th__00150
    LDA $D015
    ORA calculate_sprites$mask
    STA $D015
    LDY calculate_sprites$i
    LDA o_types.array, Y
    BPL .el__00139
    LDA calculate_sprites$i
    CLC 
    ADC #card_sprites >> 6.lo
    LDY calculate_sprites$s
    STA $B7F8, Y
    LDY calculate_sprites$i
    LDA o_types.array, Y
    AND #1
    ASL 
    LDY calculate_sprites$s
    STA $D027, Y
    BCC .fi__00140
.el__00139
    LDY calculate_sprites$i
    LDA o_types.array, Y
    CLC 
    ADC #standard_sprites >> 6.lo
    LDY calculate_sprites$s
    STA $B7F8, Y
    LDA is_game_over
    BNE .el__00137
    LDA #3
    BNE .fi__00138
.el__00137
    LDA animation_countdown
    AND #8
    BNE .el__00135
    LDA #7
    BNE .fi__00136
.el__00135
    LDA #2
.fi__00136
.fi__00138
    LDY calculate_sprites$s
    STA $D027, Y
.fi__00140
    LDA calculate_sprites$i
    BNE .el__00148
    LDA calculate_sprites$s
    ASL 
    TAY 
    LDA o_position_lo.array
    STA $D000, Y
    LDA o_lane.array
    JSR get_y_for_lane
    CLC 
    ADC bike_progress
    PHA 
    LDA calculate_sprites$s
    ASL 
    TAY 
    PLA 
    STA $D001, Y
    LDA $D017
    ORA calculate_sprites$mask
    STA $D017
    LDA $D01D
    ORA calculate_sprites$mask
    STA $D01D
    JMP .fi__00149
.el__00148
    LDY calculate_sprites$i
    LDA o_flying_y.array, Y
    BEQ .el__00146
    LDY calculate_sprites$i
    LDA o_position_lo.array, Y
    PHA 
    LDA calculate_sprites$s
    ASL 
    TAY 
    PLA 
    STA $D000, Y
    LDY calculate_sprites$i
    LDA o_position_hi.array, Y
    AND #1
    BEQ .fi__00141
    LDA $D010
    ORA calculate_sprites$mask
    STA $D010
.fi__00141
    LDY calculate_sprites$i
    LDA o_flying_y.array, Y
    AND #$10
    BNE .el__00142
    LDA $D017
    ORA calculate_sprites$mask
    STA $D017
    LDY calculate_sprites$i
    LDA o_flying_y.array, Y
    PHA 
    LDA calculate_sprites$s
    JMP .fi__00143
.el__00142
    LDY calculate_sprites$i
    LDA o_flying_y.array, Y
    CLC 
    ADC #9
    PHA 
    LDA calculate_sprites$s
.fi__00143
    ASL 
    TAY 
    PLA 
    STA $D001, Y
    LDY calculate_sprites$i
    LDA o_flying_y.array, Y
    CLC 
    ADC #8
    AND #$10
    BNE .fi__00144
    LDA #8
    LDY calculate_sprites$s
    STA $B7F8, Y
    LDA #$E
    STA $D027, Y
.fi__00144
    BPL .fi__00147
.el__00146
    LDY calculate_sprites$i
    LDA o_position_lo.array, Y
    PHA 
    LDA calculate_sprites$s
    ASL 
    TAY 
    PLA 
    STA $D000, Y
    LDY calculate_sprites$i
    LDA o_lane.array, Y
    JSR get_y_for_lane
    PHA 
    LDA calculate_sprites$s
    ASL 
    TAY 
    PLA 
    STA $D001, Y
    LDY calculate_sprites$i
    LDA o_position_hi.array, Y
    AND #1
    BEQ .fi__00145
    LDA $D010
    ORA calculate_sprites$mask
    STA $D010
.fi__00145
    LDA $D017
    ORA calculate_sprites$mask
    STA $D017
.fi__00147
.fi__00149
.fi__00151
    ASL calculate_sprites$mask
    INC calculate_sprites$s
    JMP .wh__00131
.ew__00134
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $de8
animate_hand_color
    LDA animation_countdown
    BEQ .lj80000
    JMP .el__00024
.lj80000
    LDA is_game_over
    BEQ .el__00017
    LDA game_over_message_offset
    CLC 
    ADC #$10
    AND #$1F
    STA game_over_message_offset
    LDA #$10
    STA animate_hand_color$i
.do__00004
    DEC animate_hand_color$i
    LDA game_over_message_offset
    CLC 
    ADC animate_hand_color$i
    TAY 
    LDA txt_game_over.array, Y
    LDY animate_hand_color$i
    STA $B490, Y
    LDA #2
    STA $D890, Y
    LDA animate_hand_color$i
    BNE .do__00004
    LDA #$64
    STA animation_countdown
    LDA o_types.array
    CMP #5
    BCC .el__00008
    LDA #0
    STA o_types.array
    BEQ .fi__00009
.el__00008
    LDA o_types.array
    BEQ .fi__00007
    INC o_types.array
.fi__00007
.fi__00009
    JMP .fi__00018
.el__00017
    LDA #$10
    STA animate_hand_color$i
.do__00010
    DEC animate_hand_color$i
    LDA #$20
    LDY animate_hand_color$i
    STA $B490, Y
    TYA 
    BNE .do__00010
    LDA hand_size
    BNE .fi__00016
    LDA #5
    STA animate_hand_color$i
.do__00013
    DEC animate_hand_color$i
    LDA animate_hand_color$i
    JSR clear_card_on_screen
    LDA animate_hand_color$i
    BNE .do__00013
.fi__00016
.fi__00018
    JMP .fi__00025
.el__00024
    LDA animation_countdown
    AND #$10
    BNE .el__00019
    LDA #7
    BNE .fi__00020
.el__00019
    LDA #2
.fi__00020
    TAX 
    LDA #$10
    STA animate_hand_color$i
.do__00021
    DEC animate_hand_color$i
    TXA 
    LDY animate_hand_color$i
    STA $D890, Y
    TYA 
    BNE .do__00021
.fi__00025
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $e90
get_hand_type
    LDY #4
.ai__00090.do__00063
    DEY 
    LDA #0
    STA had_suits.array, Y
    TYA 
    BNE .ai__00090.do__00063
    LDY #$D
.ai__00090.do__00066
    DEY 
    LDA #0
    STA had_ranks.array, Y
    TYA 
    BNE .ai__00090.do__00066
    LDY #5
.ai__00090.do__00069
    DEY 
    LDA hand.array, Y
    LSR 
    LSR 
    AND #$F
    TAX 
    INC had_ranks.array, X
    LDA hand.array, Y
    AND #3
    TAX 
    INC had_suits.array, X
    TYA 
    BNE .ai__00090.do__00069
    LDY #6
.ai__00091.do__00051
    DEY 
    LDA #0
    STA had_counts.array, Y
    TYA 
    BNE .ai__00091.do__00051
    LDY #$D
.ai__00091.do__00054
    DEY 
    LDX had_ranks.array, Y
    INC had_counts.array, X
    TYA 
    BNE .ai__00091.do__00054
    LDA had_counts.array + 5
    BEQ .fi__00081
    LDA #9
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
.fi__00081
    LDA had_counts.array + 4
    BEQ .fi__00082
    LDA #7
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
.fi__00082
    LDA had_counts.array + 3
    BEQ .fi__00084
    LDA had_counts.array + 2
    BEQ .fi__00083
    LDA #6
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
.fi__00083
    LDA #3
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
.fi__00084
    LDA had_counts.array + 2
    BEQ .fi__00085
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
.fi__00085
    LDY #6
.ai__00092.do__00057
    DEY 
    LDA #0
    STA had_counts.array, Y
    TYA 
    BNE .ai__00092.do__00057
    LDY #4
.ai__00092.do__00060
    DEY 
    LDX had_suits.array, Y
    INC had_counts.array, X
    TYA 
    BNE .ai__00092.do__00060
    BEQ .ai__00093.he__00073
.ai__00093.wh__00072
    LDA had_ranks.array, Y
    BEQ .ai__00093.fi__00076
    TYA 
    TAX 
.ai__00093.fi__00076
    INY 
.ai__00093.he__00073
    CPY #$D
    BCC .ai__00093.wh__00072
    LDY #$D
.ai__00093.do__00077
    DEY 
    LDA had_ranks.array, Y
    BEQ .ai__00093.fi__00080
    STY __calculate_spread$min
.ai__00093.fi__00080
    TYA 
    BNE .ai__00093.do__00077
    TXA 
    SBC __calculate_spread$min
    CMP #4
    BNE .el__00088
    LDA had_counts.array + 5
    BEQ .fi__00086
    LDA #8
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
.fi__00086
    LDA #4
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
    BNE .fi__00089
.el__00088
    LDA had_counts.array + 5
    BEQ .fi__00087
    LDA #5
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
.fi__00087
.fi__00089
    LDA #0
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $f50
display_score
    LDA #6
    STA put_dec_byte$at
    LDA score
    STA put_dec_byte$b
    JSR put_dec_byte
    LDA #4
    STA put_dec_byte$at
    LDA score + 1
    STA put_dec_byte$b
    JSR put_dec_byte
    LDA #2
    STA put_dec_byte$at
    LDA score + 2
    STA put_dec_byte$b
    JSR put_dec_byte
    LDA #0
    STA put_dec_byte$at
    LDA score + 3
    STA put_dec_byte$b
    JMP put_dec_byte
* = $f88
init_game
    LDA #0
    STA hand_size
    STA score
    STA score + 1
    STA score + 2
    STA score + 3
    LDA #$FF
    STA fuel
    LDA #$23
    STA fuel + 1
    LDA #0
    STA bike_direction
    LDY #8
.do__00332
    DEY 
    LDA #0
    STA o_types.array, Y
    STA o_flying_y.array, Y
    TYA 
    BNE .do__00332
    LDA #1
    STA o_types.array
    STA o_lane.array
    LDA #0
    STA o_position_lo.array
    STA o_position_hi.array
    STA bike_progress
    JSR clear_screen
    LDA #8
    STA draw_card_to_sprite$sprite_pointer
    LDA #0
    STA draw_card_to_sprite$card
    JSR draw_card_to_sprite
    LDA #5
    STA spawn_countdown
    LDA #0
    STA spawn_countdown + 1
    LDA #2
    STA game_speed
    LDA #$28
    STA countdown_until_acceleration
    LDA #0
    STA animation_countdown
    STA is_game_over
    LDA #$7F
    STA sound_countdown
    LDA #snd_jingle + $16.lo
    STA sound_pointer
    LDA #snd_jingle + $16.hi
    STA sound_pointer + 1
    LDY #$18
.ai__00335.do__00238
    DEY 
    LDA #0
    STA $D400, Y
    TYA 
    BNE .ai__00335.do__00238
    LDA #$F
    STA $D418
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $1015
clear_screen
    LDA #$FA
    STA clear_screen$i
.do__00261
    DEC clear_screen$i
    LDA #$20
    LDY clear_screen$i
    STA $B400, Y
    TYA 
    BNE .do__00261
    LDA #$F0
    STA clear_screen$p
    LDA #$B4
    STA clear_screen$p + 1
    LDA #$13
    STA clear_screen$i
.do__00264
    DEC clear_screen$i
    JSR rand
    AND #$F
    TAX 
    LDA #0
    STA clear_screen$x
    BEQ .he__00268
.wh__00267
    TXA 
    CLC 
    ADC clear_screen$x
    AND #$F
    ORA #$60
    LDY clear_screen$x
    STA (clear_screen$p), Y
    INC clear_screen$x
.he__00268
    LDA clear_screen$x
    CMP #$28
    BCC .wh__00267
    CLC 
    LDA clear_screen$p
    ADC #$28
    STA clear_screen$p
    BCC .ah__30008
    INC clear_screen$p + 1
.ah__30008
    LDA clear_screen$i
    BNE .do__00264
    LDA #5
    STA clear_screen$i
.do__00271
    DEC clear_screen$i
    LDY clear_screen$i
    LDA txt_score.array, Y
    STA $B44B, Y
    LDA txt_fuel.array, Y
    STA $B423, Y
    LDA #1
    STA $D823, Y
    STA $D84B, Y
    LDA clear_screen$i
    BNE .do__00271
    LDA #8
    STA clear_screen$i
.do__00274
    DEC clear_screen$i
    LDA #1
    LDY clear_screen$i
    STA $D842, Y
    TYA 
    BNE .do__00274
    JSR display_score
    JMP display_fuel
* = $10aa
destroy_object
    TAX 
    LDA #0
    STA o_types.array, X
    STA o_flying_y.array, X
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $10b4
show_title_screen
    LDA #$FA
    STA show_title_screen$i
.do__00277
    DEC show_title_screen$i
    LDA #$20
    LDY show_title_screen$i
    STA $B400, Y
    STA $B4FA, Y
    STA $B5F4, Y
    STA $B6EE, Y
    LDA #1
    STA $D800, Y
    STA $D8FA, Y
    STA $D9F4, Y
    STA $DAEE, Y
    LDA show_title_screen$i
    BNE .do__00277
    LDA #0
    STA title_sprite_pos
    STA title_sprite_pos + 1
    LDA #$FF
    STA $D017
    LDA #1
    STA $D01D
    LDA #3
    STA $D027
    LDA #0
    STA $D029
    STA $D02B
    LDA #2
    STA $D028
    STA $D02A
    STA $D02C
    LDA #1 + standard_sprites >> 6.lo
    STA $B7F8
    LDA #(card_sprites >> 6.lo) + (1)
    STA $B7F9
    LDA #(card_sprites >> 6.lo) + (2)
    STA $B7FA
    LDA #(card_sprites >> 6.lo) + (3)
    STA $B7FB
    LDA #(card_sprites >> 6.lo) + (4)
    STA $B7FC
    LDA #(card_sprites >> 6.lo) + (5)
    STA $B7FD
    LDA #(card_sprites >> 6.lo) + (1)
    STA draw_card_to_sprite$sprite_pointer
    LDA #$30
    STA draw_card_to_sprite$card
    JSR draw_card_to_sprite
    LDA #(card_sprites >> 6.lo) + (2)
    STA draw_card_to_sprite$sprite_pointer
    LDA #$2D
    STA draw_card_to_sprite$card
    JSR draw_card_to_sprite
    LDA #(card_sprites >> 6.lo) + (3)
    STA draw_card_to_sprite$sprite_pointer
    LDA #$2B
    STA draw_card_to_sprite$card
    JSR draw_card_to_sprite
    LDA #(card_sprites >> 6.lo) + (4)
    STA draw_card_to_sprite$sprite_pointer
    LDA #$26
    STA draw_card_to_sprite$card
    JSR draw_card_to_sprite
    LDA #(card_sprites >> 6.lo) + (5)
    STA draw_card_to_sprite$sprite_pointer
    LDA #$21
    STA draw_card_to_sprite$card
    JSR draw_card_to_sprite
    LDA #$A2
    STA $D001
    LDA #$63
    STA $D005
    STA $D009
    LDA #$67
    STA $D003
    STA $D007
    STA $D00B
    LDA #$69
    STA $D002
    LDA #$87
    STA $D004
    LDA #$A5
    STA $D006
    LDA #$C3
    STA $D008
    LDA #$E1
    STA $D00A
    LDA #$3F
    STA $D015
    LDA #$C
    STA show_title_screen$i
.do__00280
    DEC show_title_screen$i
    LDY show_title_screen$i
    LDA txt_title.array, Y
    STA $B45E, Y
    LDA show_title_screen$i
    BNE .do__00280
    LDA #$10
    STA show_title_screen$i
.do__00283
    DEC show_title_screen$i
    LDY show_title_screen$i
    LDA txt_copyright.array, Y
    STA $B4AC, Y
    LDA show_title_screen$i
    BNE .do__00283
    LDA #$13
    STA show_title_screen$i
.do__00286
    DEC show_title_screen$i
    LDY show_title_screen$i
    LDA txt_hiscore.array, Y
    STA $B72B, Y
    LDA show_title_screen$i
    BNE .do__00286
    LDA #$13
    STA show_title_screen$i
.do__00289
    DEC show_title_screen$i
    LDY show_title_screen$i
    LDA txt_press_fire.array, Y
    STA $B77B, Y
    LDA show_title_screen$i
    BNE .do__00289
    JSR display_hi_score
    JMP .he__00293
.wh__00292
    JSR title_screen_frame
.he__00293
    LDA input_btn
    BNE .wh__00292
    BEQ .he__00297
.wh__00296
    JSR title_screen_frame
.he__00297
    LDA input_btn
    BEQ .wh__00296
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $120e
check_and_process_hand
    LDA hand_size
    CMP #5
    BCS .fi__00104
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
.fi__00104
    JSR get_hand_type
    STA check_and_process_hand$type
    LDA check_and_process_hand$type
    BEQ .fi__00105
    LDA #snd_jingle.lo
    STA play_sound$addr
    LDA #snd_jingle.hi
    STA play_sound$addr + 1
    JSR play_sound
.fi__00105
    ASL check_and_process_hand$type
    LDY check_and_process_hand$type
    LDA scores.array + 1, Y
    CLC 
    SED 
    ADC score
    STA score
    LDA scores.array, Y
    ADC score + 1
    STA score + 1
    LDA score + 2
    ADC #0
    STA score + 2
    LDA score + 3
    ADC #0
    CLD 
    STA score + 3
    JSR display_score
    LDA fuel + 1
    CLC 
    ADC check_and_process_hand$type
    STA fuel + 1
    CMP #$23
    BCC .fi__00106
    BEQ .fi__00106
    LDA #$23
    STA fuel + 1
.fi__00106
    LDA #$64
    STA animation_countdown
    ASL check_and_process_hand$type
    ASL check_and_process_hand$type
    ASL check_and_process_hand$type
    LDA #$10
    STA check_and_process_hand$i
.do__00107
    DEC check_and_process_hand$i
    LDA check_and_process_hand$i
    CLC 
    ADC check_and_process_hand$type
    TAY 
    LDA text.array, Y
    LDY check_and_process_hand$i
    STA $B490, Y
    LDA #1
    STA $D890, Y
    LDA check_and_process_hand$i
    BNE .do__00107
    LDA #0
    STA hand_size
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $12a8
move_objects
    LDA is_game_over
    BEQ .lj80001
    JMP .el__00178
.lj80001
    LDA input_dy
    BEQ .fi__00169
    STA bike_direction
.fi__00169
    LDA o_lane.array
    BNE .el__00171
    LDA bike_progress
    BNE .el__00171
    BIT bike_direction
    BPL .el__00171
    LDA #0
    STA bike_direction
    BEQ .fi__00172
.el__00171
    LDA o_lane.array
    CMP #2
    BNE .fi__00170
    LDA bike_direction
    BMI .fi__00170
    BEQ .fi__00170
    LDA #0
    STA bike_direction
.fi__00170
.fi__00172
    LDA bike_progress
    BNE .fi__00173
    BIT bike_direction
    BPL .fi__00173
    DEC o_lane.array
.fi__00173
    LDA bike_progress
    CLC 
    ADC bike_direction
    AND #$1F
    STA bike_progress
    LDA bike_progress
    BNE .ai__00201.fi__00168
    LDA bike_direction
    BMI .ai__00201.fi__00167
    BEQ .ai__00201.fi__00167
    INC o_lane.array
.ai__00201.fi__00167
    LDA #0
    STA bike_direction
.ai__00201.fi__00168
    LDA o_position_lo.array
    CLC 
    ADC input_dx
    CLC 
    ADC input_dx
    STA o_position_lo.array
    CMP #$18
    BCS .el__00175
    LDA #$18
    STA o_position_lo.array
    BNE .fi__00176
.el__00175
    LDA o_position_lo.array
    CMP #$FC
    BCC .fi__00174
    LDA #$FC
    STA o_position_lo.array
.fi__00174
.fi__00176
    JMP .fi__00179
.el__00178
    LDA input_btn
    BEQ .fi__00177
    LDA #1
    STA restart_game
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
.fi__00177
.fi__00179
    LDA #1
    STA move_objects$i
.wh__00180
    LDA move_objects$i
    CMP #8
    BCC .he__00181
    JMP .ew__00183
.he__00181
    LDY move_objects$i
    LDA o_types.array, Y
    BNE .fi__00184
    JMP .fp__00182
.fi__00184
    LDY move_objects$i
    LDA o_flying_y.array, Y
    BEQ .el__00199
    LDY move_objects$i
    LDA o_flying_y.array, Y
    SEC 
    SBC #2
    STA o_flying_y.array, Y
    CMP #$30
    BCS .fi__00190
    LDA hand_size
    BNE .fi__00188
    LDY #5
.do__00185
    DEY 
    TYA 
    JSR clear_card_on_screen
    TYA 
    BNE .do__00185
.fi__00188
    LDA is_game_over
    BNE .fi__00189
    LDY move_objects$i
    LDA o_types.array, Y
    LDY hand_size
    STA draw_card_to_screen$card
    STA hand.array, Y
    STY draw_card_to_screen$position
    JSR draw_card_to_screen
    INC hand_size
    JSR check_and_process_hand
.fi__00189
    LDA move_objects$i
    JSR destroy_object
.fi__00190
    JMP .fi__00200
.el__00199
    LDY move_objects$i
    SEC 
    LDA o_position_lo.array, Y
    SBC game_speed
    STA move_objects$pos
    LDA o_position_hi.array, Y
    SBC #0
    AND #1
    STA move_objects$pos + 1
    LDA is_game_over
    BNE .fi__00196
    SEC 
    LDA move_objects$pos
    SBC o_position_lo.array
    STA move_objects$dpos
    LDA move_objects$pos + 1
    SBC #0
    STA move_objects$dpos + 1
    CLC 
    LDA move_objects$dpos
    ADC #$18
    STA move_objects$dpos
    BCC .ah__30004
    INC move_objects$dpos + 1
.ah__30004
    LDA move_objects$dpos + 1
    BNE .fi__00194
    LDA move_objects$dpos
    CMP #$48
    BCS .fi__00194
    LDA bike_progress
    AND #$10
    BNE .el__00192
    LDY move_objects$i
    LDA o_lane.array, Y
    CMP o_lane.array
    BNE .el__00192
    LDA move_objects$i
    JSR touch_object
    JMP .fi__00193
.el__00192
    LDA bike_progress
    AND #$10
    BEQ .fi__00191
    LDA o_lane.array
    CLC 
    ADC #1
    LDY move_objects$i
    CMP o_lane.array, Y
    BNE .fi__00191
    LDA move_objects$i
    JSR touch_object
.fi__00191
.fi__00193
.fi__00194
.fi__00196
    LDA move_objects$pos + 1
    BNE .fi__00197
    LDA move_objects$pos
    CMP game_speed
    BCS .fi__00197
    LDA move_objects$i
    JSR destroy_object
.fi__00197
    LDA move_objects$pos
    LDY move_objects$i
    STA o_position_lo.array, Y
    LDA move_objects$pos + 1
    STA o_position_hi.array, Y
.fi__00200
.fp__00182
    INC move_objects$i
    JMP .wh__00180
.ew__00183
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $1440
__mul_u8u8u8
    LDA #0
    BEQ __mul_u8u8u8_start
__mul_u8u8u8_add
    CLC 
    ADC __reg
__mul_u8u8u8_loop
    ASL __reg
__mul_u8u8u8_start
    LSR __reg + 1
    BCS __mul_u8u8u8_add
    BNE __mul_u8u8u8_loop
    RTS 
* = $1453
put_dec_byte
    LDA put_dec_byte$b
    AND #$F
    ORA #$30
    LDX put_dec_byte$at
    STA screen + $43, X
    LDA put_dec_byte$b
    LSR 
    LSR 
    LSR 
    LSR 
    AND #$F
    ORA #$30
    STA screen + $42, X
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $146f
rand
    LDX #8
    LDA rand_seed
__rand_loop
    ASL 
    ROL rand_seed + 1
    BCC __no_eor
    EOR #$2D
__no_eor
    DEX 
    BNE __rand_loop
    STA rand_seed
    RTS 
* = $1483
clear_card_on_screen
    ASL 
    ASL 
    STA clear_card_on_screen$position
    LDA #$12
    STA clear_card_on_screen$i
.do__00001
    DEC clear_card_on_screen$i
    LDX clear_card_on_screen$i
    LDA positions_to_clear.array, X
    CLC 
    ADC clear_card_on_screen$position
    TAX 
    LDA #$20
    STA screen + $29, X
    LDA clear_card_on_screen$i
    BNE .do__00001
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $14a6
game_over
    LDA #1
    STA is_game_over
    SEC 
    LDA hi_score
    SBC score
    LDA hi_score + 1
    SBC score + 1
    LDA hi_score + 2
    SBC score + 2
    LDA hi_score + 3
    SBC score + 3
    BCS .fi__00026
    LDA score
    STA hi_score
    LDA score + 1
    STA hi_score + 1
    LDA score + 2
    STA hi_score + 2
    LDA score + 3
    STA hi_score + 3
.fi__00026
    LDA #2
    STA o_types.array
    LDA #0
    STA game_over_message_offset
    STA animation_countdown
    JSR animate_hand_color
    LDA #snd_explosion.lo
    STA play_sound$addr
    LDA #snd_explosion.hi
    STA play_sound$addr + 1
    JMP play_sound
* = $14fb
handle_input
    LDA #0
    STA input_dx
    STA input_dy
    STA input_btn
    STA $DC02
    LDA $DC00
    TAY 
    AND #1
    BNE .ai__00102.fi__00097
    DEC input_dy
.ai__00102.fi__00097
    TYA 
    AND #2
    BNE .ai__00102.fi__00098
    INC input_dy
.ai__00102.fi__00098
    TYA 
    AND #4
    BNE .ai__00102.fi__00099
    DEC input_dx
.ai__00102.fi__00099
    TYA 
    AND #8
    BNE .ai__00102.fi__00100
    INC input_dx
.ai__00102.fi__00100
    TYA 
    AND #$10
    BNE .ai__00102.fi__00101
    INC input_btn
.ai__00102.fi__00101
    LDA #0
    STA $DC03
    LDA $DC01
    TAY 
    AND #1
    BNE .ai__00103.fi__00046
    DEC input_dy
.ai__00103.fi__00046
    TYA 
    AND #2
    BNE .ai__00103.fi__00047
    INC input_dy
.ai__00103.fi__00047
    TYA 
    AND #4
    BNE .ai__00103.fi__00048
    DEC input_dx
.ai__00103.fi__00048
    TYA 
    AND #8
    BNE .ai__00103.fi__00049
    INC input_dx
.ai__00103.fi__00049
    TYA 
    AND #$10
    BNE .ai__00103.fi__00050
    INC input_btn
.ai__00103.fi__00050
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $1562
update_screen
    JSR handle_input
    JSR move_objects
    JSR calculate_sprites
    LDA is_game_over
    BNE .fi__00226
    JSR check_and_process_hand
    SEC 
    LDA fuel
    SBC game_speed
    STA fuel
    LDA fuel + 1
    SBC #0
    STA fuel + 1
    LDA fuel
    ORA fuel + 1
    BEQ .or__00225
    LDA fuel + 1
    CMP #$FF
    BNE .fi__00224
.or__00225
    LDA #0
    STA fuel
    STA fuel + 1
    JSR game_over
.fi__00224
    JSR display_fuel
.fi__00226
    LDA animation_countdown
    BEQ .fi__00227
    DEC animation_countdown
    JSR animate_hand_color
.fi__00227
    SEC 
    LDA spawn_countdown
    SBC game_speed
    STA spawn_countdown
    LDA spawn_countdown + 1
    SBC #0
    STA spawn_countdown + 1
    LDA spawn_countdown + 1
    BEQ .lj80002
    JMP .fi__00234
.lj80002
    LDA spawn_countdown
    CMP game_speed
    BCC .lj80003
    JMP .fi__00234
.lj80003
.ai__00236.do__00202
    JSR rand
    AND #$3F
    ORA #$80
    STA get_random_card$card
    AND #$3C
    CMP #$34
    BCS .ai__00236.do__00202
    LDA get_random_card$card
    JSR card_exists
    CMP #0
    BNE .ai__00236.do__00202
    LDA get_random_card$card
    STA spawn_object$type
.ai__00237.do__00205
    JSR rand
    AND #3
    TAY 
    CMP last_lane
    BEQ .ai__00237.do__00205
    CPY #2
    BEQ .ai__00237.co__00208
    BCS .ai__00237.do__00205
.ai__00237.co__00208
    TYA 
    STA last_lane
    STA spawn_object$lane
    JSR spawn_object
    JSR rand
    AND #$1F
    PHA 
    JSR rand
    AND #$F
    CLC 
    ADC #$A
    STA __reg
    LDA game_speed
    STA __reg + 1
    JSR __mul_u8u8u8
    TSX 
    CLC 
    ADC $101, X
    INX 
    TXS 
    ASL 
    STA spawn_countdown
    LDA #0
    ROL 
    STA spawn_countdown + 1
    LDA is_game_over
    BNE .fi__00233
    LDA game_speed
    CMP #8
    BCS .fi__00233
    DEC countdown_until_acceleration
    BNE .fi__00232
    INC game_speed
    LDA #snd_hurry_up.lo
    STA play_sound$addr
    LDA #snd_hurry_up.hi
    STA play_sound$addr + 1
    JSR play_sound
    LDY #$10
.do__00229
    DEY 
    LDA txt_acceleration.array, Y
    STA $B490, Y
    TYA 
    BNE .do__00229
    LDA #$64
    STA animation_countdown
    LDA #$28
    STA countdown_until_acceleration
.fi__00232
.fi__00233
.fi__00234
    LDA charset + $300
    ASL 
    ROL charset + $378
    ROL charset + $370
    ROL charset + $368
    ROL charset + $360
    ROL charset + $358
    ROL charset + $350
    ROL charset + $348
    ROL charset + $340
    ROL charset + $338
    ROL charset + $330
    ROL charset + $328
    ROL charset + $320
    ROL charset + $318
    ROL charset + $310
    ROL charset + $308
    ROL charset + $300
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $169d
hi_put_dec_byte
    LDA hi_put_dec_byte$b
    AND #$F
    ORA #$30
    LDX hi_put_dec_byte$at
    STA screen + $337, X
    LDA hi_put_dec_byte$b
    LSR 
    LSR 
    LSR 
    LSR 
    AND #$F
    ORA #$30
    STA screen + $336, X
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $16b9
draw_card_to_sprite
    LDA draw_card_to_sprite$sprite_pointer
    ASL 
    STA draw_card_to_sprite$target
    LDA #0
    ROL 
    STA draw_card_to_sprite$target + 1
    ASL draw_card_to_sprite$target
    ROL draw_card_to_sprite$target + 1
    ASL draw_card_to_sprite$target
    ROL draw_card_to_sprite$target + 1
    ASL draw_card_to_sprite$target
    ROL draw_card_to_sprite$target + 1
    ASL draw_card_to_sprite$target
    ROL draw_card_to_sprite$target + 1
    ASL draw_card_to_sprite$target
    LDA draw_card_to_sprite$target + 1
    ROL 
    EOR #$80
    STA draw_card_to_sprite$target + 1
    LDA #$2A
    LDY #0
    STA (draw_card_to_sprite$target), Y
    LDA #$AA
    INY 
    STA (draw_card_to_sprite$target), Y
    LDA #$A8
    INY 
    STA (draw_card_to_sprite$target), Y
    LDA #$BF
    INY 
    STA (draw_card_to_sprite$target), Y
    LDA #$FF
    INY 
    STA (draw_card_to_sprite$target), Y
    LDA #$FE
    INY 
    STA (draw_card_to_sprite$target), Y
    LDA #$BF
    LDY #$36
    STA (draw_card_to_sprite$target), Y
    LDA #$FF
    INY 
    STA (draw_card_to_sprite$target), Y
    LDA #$FE
    INY 
    STA (draw_card_to_sprite$target), Y
    LDA #$2A
    INY 
    STA (draw_card_to_sprite$target), Y
    LDA #$AA
    INY 
    STA (draw_card_to_sprite$target), Y
    LDA #$A8
    INY 
    STA (draw_card_to_sprite$target), Y
    LDA #0
    INY 
    STA (draw_card_to_sprite$target), Y
    INY 
    STA (draw_card_to_sprite$target), Y
    INY 
    STA (draw_card_to_sprite$target), Y
    LDA draw_card_to_sprite$card
    BNE .el__00165
    CLC 
    LDA draw_card_to_sprite$target
    ADC #6
    STA draw_card_to_sprite$target
    BCC .ah__30000
    INC draw_card_to_sprite$target + 1
.ah__30000
    LDY #$18
.do__00153
    DEY 
    LDA sprite_reverse_data.array, Y
    STA (draw_card_to_sprite$target), Y
    TYA 
    BNE .do__00153
    CLC 
    LDA draw_card_to_sprite$target
    ADC #$18
    STA draw_card_to_sprite$target
    BCC .ah__30001
    INC draw_card_to_sprite$target + 1
.ah__30001
    LDY #$18
.do__00156
    DEY 
    LDA sprite_reverse_data.array, Y
    STA (draw_card_to_sprite$target), Y
    TYA 
    BNE .do__00156
    JMP .fi__00166
.el__00165
    CLC 
    LDA draw_card_to_sprite$target
    ADC #6
    STA draw_card_to_sprite$target
    BCC .ah__30002
    INC draw_card_to_sprite$target + 1
.ah__30002
    LDA draw_card_to_sprite$card
    LSR 
    LSR 
    AND #$F
    STA draw_card_to_sprite$source
    LDA #0
    STA draw_card_to_sprite$source + 1
    LDA draw_card_to_sprite$source
    ASL 
    CLC 
    ADC draw_card_to_sprite$source
    ASL 
    STA draw_card_to_sprite$source
    ROL draw_card_to_sprite$source + 1
    ASL draw_card_to_sprite$source
    ROL draw_card_to_sprite$source + 1
    ASL draw_card_to_sprite$source
    ROL draw_card_to_sprite$source + 1
    CLC 
    LDA draw_card_to_sprite$source
    ADC #sprite_rank_data.array.lo
    STA draw_card_to_sprite$source
    LDA draw_card_to_sprite$source + 1
    ADC #sprite_rank_data.array.hi
    STA draw_card_to_sprite$source + 1
    LDY #$18
.do__00159
    DEY 
    LDA (draw_card_to_sprite$source), Y
    STA (draw_card_to_sprite$target), Y
    TYA 
    BNE .do__00159
    CLC 
    LDA draw_card_to_sprite$target
    ADC #$18
    STA draw_card_to_sprite$target
    BCC .ah__30003
    INC draw_card_to_sprite$target + 1
.ah__30003
    LDA draw_card_to_sprite$card
    AND #3
    STA draw_card_to_sprite$source
    LDA #0
    STA draw_card_to_sprite$source + 1
    LDA draw_card_to_sprite$source
    ASL 
    CLC 
    ADC draw_card_to_sprite$source
    ASL 
    STA draw_card_to_sprite$source
    ROL draw_card_to_sprite$source + 1
    ASL draw_card_to_sprite$source
    ROL draw_card_to_sprite$source + 1
    ASL draw_card_to_sprite$source
    ROL draw_card_to_sprite$source + 1
    CLC 
    LDA draw_card_to_sprite$source
    ADC #sprite_suit_data.array.lo
    STA draw_card_to_sprite$source
    LDA draw_card_to_sprite$source + 1
    ADC #sprite_suit_data.array.hi
    STA draw_card_to_sprite$source + 1
    LDY #$18
.do__00162
    DEY 
    LDA (draw_card_to_sprite$source), Y
    STA (draw_card_to_sprite$target), Y
    TYA 
    BNE .do__00162
.fi__00166
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $17dd
play_sound
    LDA play_sound$addr
    STA sound_pointer
    LDA play_sound$addr + 1
    STA sound_pointer + 1
    LDA #0
    STA sound_countdown
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $17ef
card_exists
    STA card_exists$card
    LDY #8
.do__00111
    DEY 
    LDA o_types.array, Y
    CMP card_exists$card
    BNE .fi__00114
    LDA #1
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
.fi__00114
    TYA 
    BNE .do__00111
    BEQ .he__00116
.wh__00115
    LDA hand.array, Y
    CMP card_exists$card
    BNE .fi__00119
    LDA #1
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
.fi__00119
    INY 
.he__00116
    CPY hand_size
    BCC .wh__00115
    LDA #0
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $1819
display_fuel
    LDY #0
.wh__00215
    LDA #$F
    STA $D800, Y
    CPY fuel + 1
    BCS .el__00219
    LDA #$1F
    BNE .fi__00220
.el__00219
    LDA #$20
.fi__00220
    STA $B400, Y
    CPY #$23
    BNE .el__00221
    BEQ .ew__00218
.el__00221
    INY 
    JMP .wh__00215
.ew__00218
    LDA fuel
    ORA fuel + 1
    BEQ .fi__00223
    LDA fuel
    ROL 
    ROL 
    ROL 
    AND #3
    CLC 
    ADC #$1B
    LDY fuel + 1
    STA $B400, Y
.fi__00223
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $1852
get_y_for_lane
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC #$64
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $185b
title_screen_frame
.ai__00254.wh__00247
    LDA $D012
    CMP #$FF
    BNE .ai__00254.wh__00247
    JSR handle_input
    CLC 
    LDA title_sprite_pos
    ADC #2
    STA title_sprite_pos
    BCC .ah__30006
    INC title_sprite_pos + 1
.ah__30006
    LDA title_sprite_pos + 1
    CMP #1
    BCC .fi__00251
    BNE .cp__00252
    LDA title_sprite_pos
    CMP #$E0
    BCC .fi__00251
.cp__00252
    LDA #0
    STA title_sprite_pos
    STA title_sprite_pos + 1
.fi__00251
    LDA title_sprite_pos + 1
    STA $D010
    LDA title_sprite_pos
    STA $D000
    AND #$1F
    BNE .fi__00253
    LDA $D003
    EOR #4
    STA $D003
    LDA $D005
    EOR #4
    STA $D005
    LDA $D007
    EOR #4
    STA $D007
    LDA $D009
    EOR #4
    STA $D009
    LDA $D00B
    EOR #4
    STA $D00B
.fi__00253
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $18c4
touch_object
    TAY 
    LDA o_types.array, Y
    BPL .fi__00110
    LDA o_flying_y.array, Y
    BNE .fi__00110
    LDA o_lane.array, Y
    JSR get_y_for_lane
    STA o_flying_y.array, Y
.fi__00110
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $18d9
sprite_reverse_data.array
    !byte $BE, $EE, $EE, $BB, $BB, $BE, $BE, $EE, $EE, $BB, $BB, $BE, $BE, $EE, $EE, $BB
    !byte $BB, $BE, $BE, $EE, $EE, $BB, $BB, $BE
* = $18f1
txt_fuel.array
    !byte $20, 6, $15, 5, $C
* = $18f6
o_flying_y.array
    !byte 0, 0, 0, 0, 0, 0, 0, 0
* = $18fe
sprite_suit_data.array
    !byte $BF, $FF, $FE, $BF, $FB, $FE, $BF, $EA, $FE, $BF, $AA, $BE, $BE, $AA, $AE, $BE
    !byte $AA, $AE, $BF, $EA, $FE, $BF, $AA, $BE, $BF, $FF, $FE, $BF, $AE, $BE, $BE, $AA
    !byte $AE, $BE, $AA, $AE, $BE, $AA, $AE, $BF, $AA, $BE, $BF, $EA, $FE, $BF, $FB, $FE
    !byte $BF, $FF, $FE, $BF, $FA, $FE, $BF, $FA, $FE, $BF, $AF, $AE, $BF, $AF, $AE, $BF
    !byte $FA, $FE, $BF, $FA, $FE, $BF, $EA, $BE, $BF, $FF, $FE, $BF, $FB, $FE, $BF, $EA
    !byte $FE, $BF, $AA, $BE, $BE, $AA, $AE, $BF, $AA, $BE, $BF, $EA, $FE, $BF, $FB, $FE
    !byte 0
* = $195f
txt_game_over.array
    !byte 6, 9, $12, 5, $20, $14, $F, $20, $12, 5, $13, $14, 1, $12, $14, $20
    !byte 7, 1, $D, 5, $20, $F, $16, 5, $12, $20, $20, $20, $20, $20, $20, $20
* = $197f
snd_hurry_up.array
    !byte $A, 8, $B, $10, 7, $AE, 8, $20, $C, 0, $D, $E0, $B, $11, $88, $B
    !byte $10, $83, $B, $11, $88, $B, $10, $83, $B, $11, $88, $B, $10, $FF
* = $199d
sprite_rank_data.array
    !byte $BE, $AB, $FE, $BA, $FA, $FE, $BF, $FA, $FE, $BF, $EB, $FE, $BE, $BF, $FE, $BA
    !byte $FF, $FE, $BA, $AA, $FE, $BF, $FF, $FE, $BE, $AB, $FE, $BA, $FA, $FE, $BF, $FA
    !byte $FE, $BF, $AB, $FE, $BF, $FA, $FE, $BA, $FA, $FE, $BE, $AB, $FE, $BF, $FF, $FE
    !byte $BF, $FA, $FE, $BF, $EA, $FE, $BF, $AA, $FE, $BA, $FA, $FE, $BA, $AA, $BE, $BF
    !byte $FA, $FE, $BF, $FA, $FE, $BF, $FF, $FE, $BA, $AA, $FE, $BA, $FF, $FE, $BA, $AB
    !byte $FE, $BF, $FA, $FE, $BF, $FA, $FE, $BA, $FA, $FE, $BE, $AB, $FE, $BF, $FF, $FE
    !byte $BE, $AB, $FE, $BA, $FA, $FE, $BA, $FF, $FE, $BA, $AB, $FE, $BA, $FA, $FE, $BA
    !byte $FA, $FE, $BE, $AB, $FE, $BF, $FF, $FE, $BA, $AA, $FE, $BA, $FA, $FE, $BF, $EB
    !byte $FE, $BF, $AF, $FE, $BF, $AF, $FE, $BF, $AF, $FE, $BF, $AF, $FE, $BF, $FF, $FE
    !byte $BE, $AB, $FE, $BA, $FA, $FE, $BA, $FA, $FE, $BE, $AB, $FE, $BA, $FA, $FE, $BA
    !byte $FA, $FE, $BE, $AB, $FE, $BF, $FF, $FE, $BE, $AB, $FE, $BA, $FA, $FE, $BA, $FA
    !byte $FE, $BE, $AA, $FE, $BF, $FA, $FE, $BA, $FA, $FE, $BE, $AB, $FE, $BF, $FF, $FE
    !byte $BA, $FA, $BE, $BA, $EB, $AE, $BA, $EB, $AE, $BA, $EB, $AE, $BA, $EB, $AE, $BA
    !byte $EB, $AE, $BA, $FA, $BE, $BF, $FF, $FE, $BF, $AA, $FE, $BF, $EB, $FE, $BF, $EB
    !byte $FE, $BF, $EB, $FE, $BF, $EB, $FE, $BA, $EB, $FE, $BE, $AF, $FE, $BF, $FF, $FE
    !byte $BE, $AB, $FE, $BA, $FA, $FE, $BA, $FA, $FE, $BA, $FA, $FE, $BA, $FA, $FE, $BE
    !byte $AB, $FE, $BF, $EA, $FE, $BF, $FF, $FE, $BA, $FA, $FE, $BA, $EB, $FE, $BA, $AF
    !byte $FE, $BA, $BF, $FE, $BA, $AF, $FE, $BA, $EB, $FE, $BA, $FA, $FE, $BF, $FF, $FE
    !byte $BF, $AF, $FE, $BE, $AB, $FE, $BA, $FA, $FE, $BA, $AA, $FE, $BA, $FA, $FE, $BA
    !byte $FA, $FE, $BA, $FA, $FE, $BF, $FF, $FE, 0
* = $1ad6
char_offsets2.array
    !byte 0, $20, $40, 2, $22, $42, 4, $24, $44, 6, $26, $46
* = $1ae2
positions_to_clear.array
    !byte 0, 1, 2, $28, $29, $2A, $50, $51, $52, $78, $79, $7A, $A0, $A1, $A2, $C8
    !byte $C9, $CA
* = $1af4
txt_acceleration.array
    !byte $C, 5, $14, $27, $13, $20, 7, $F, $20, 6, 1, $13, $14, 5, $12, $21
* = $1b04
txt_title.array
    !byte $13, $10, 1, 3, 5, $20, $20, $10, $F, $B, 5, $12
* = $1b10
__constant8
    !byte 8
* = $1b11
txt_hiscore.array
    !byte 8, 9, $20, $13, 3, $F, $12, 5, $3A, $20, $20, $30, $30, $30, $30, $30
    !byte $30, $30, $30
* = $1b24
snd_explosion.array
    !byte 7, 5, 8, 5, $C, $12, $D, $AD, $B, $81, $99, $B, $80, $FF
* = $1b32
fuel_bar.array
    !byte 0, 0, $C0, $C0, $C0, $C0, 0, 0, 0, $C0, $B0, $F0, $F0, $B0, $C0, 0
    !byte 0, $F0, $AC, $FC, $FC, $AC, $F0, 0, 0, $FC, $AB, $FF, $FF, $AB, $FC, 0
    !byte 0, $FF, $AA, $FF, $FF, $AA, $FF, 0
* = $1b5a
char_offsets.array
    !byte 0, 8, $10, 2, $A, $12, 4, $C, $14, 6, $E, $16
* = $1b66
txt_press_fire.array
    !byte $10, $12, 5, $13, $13, $20, 6, 9, $12, 5, $20, $14, $F, $20, $13, $14
    !byte 1, $12, $14
* = $1b79
snd_jingle.array
    !byte $B, $10, $A, 8, 7, $22, 8, $22, $C, $11, $D, $E3, $B, $11, $82, 7
    !byte $33, 8, $33, $82, $B, $10, $FF
* = $1b90
txt_copyright.array
    !byte 2, $19, $20, $B, 1, $12, $F, $C, $20, $13, $14, 1, $13, 9, 1, $B
* = $1ba0
txt_score.array
    !byte $13, 3, $F, $12, 5
* = $1ba5
scores.array
    !byte 0, 0, 0, 1, 0, 3, 0, $10, 0, $20, 0, $50, 1, 0, 3, 0
    !byte $10, 0, $10, 0
* = $1bb9
o_types.array
    !byte 1, 0, 0, 0, 0, 0, 0, 0
* = $1bc1
sprite_bike_data.array
    !byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, $55
    !byte $40, 0, $1F, $D0, 0, 6, $A4, 0, 1, $A9, $54, 1, $55, $A5, 3, $FF
    !byte $69, 1, $55, $A5, 1, $A9, $54, 6, $A4, 0, $1F, $D0, 0, $55, $40, 0
    !byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, $8F
    !byte 0, $25, $40, 2, $AF, $40, 5, $5D, $40, 6, $AB, $40, $16, $FE, $80, $7E
    !byte $EF, $90, $FB, $EE, $90, $EB, $AE, $9A, $EF, $AE, $B6, $EF, $AB, $BD, $EF, $AB
    !byte $FD, $EF, $AB, $F5, $6B, $AF, $B4, $7B, $FF, $BD, $3B, $FE, $AD, $2B, $FE, $AD
    !byte $2A, $A6, $AD, $1E, $D7, $F4, $1E, $D7, $F0, 5, $A0, 0, 0, $50, 0, $82
    !byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, $F0, 0, 2, $B4, 0, $52
    !byte $EB, $40, $5E, $BA, $D4, $5E, $96, $A5, $FE, $FF, $EC, $EA, $DF, $AD, $EA, $BF
    !byte $BD, $6A, $FD, $BD, $6F, $BA, $BC, $2E, $AB, $F0, $2A, $FF, $D0, $1F, $FF, $40
    !byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, $82
    !byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    !byte 0, 0, $70, 0, 0, $71, 0, 0, $6F, $50, 0, $2A, $AB, $C4, $2A, $1A
    !byte $A9, $2C, $AA, $B4, $2A, $90, 0, $1A, $40, 0, $54, 0, 0, 0, 0, 0
    !byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, $82
    !byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    !byte 0, 0, 0, 0, 0, $18, 0, 0, $1A, 0, 0, $16, 0, 0, $13, $C0
    !byte $F5, $14, $C0, 4, 2, $AA, 0, 2, 0, 0, $15, 0, 0, $1A, 0, 0
    !byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
* = $1d00
text.array
    !byte $E, $F, $14, 8, 9, $E, 7, $20, $20, $20, $20, $20, $20, $20, $20, $20
    !byte $F, $E, 5, $20, $10, 1, 9, $12, $20, $20, $20, $20, $20, $20, $20, $20
    !byte $14, $17, $F, $20, $10, 1, 9, $12, $13, $20, $20, $20, $20, $20, $20, $20
    !byte $14, 8, $12, 5, 5, $20, $F, 6, $20, 1, $20, $B, 9, $E, 4, $20
    !byte $13, $14, $12, 1, 9, 7, 8, $14, $20, $20, $20, $20, $20, $20, $20, $20
    !byte 6, $C, $15, $13, 8, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
    !byte 6, $15, $C, $C, $20, 8, $F, $15, $13, 5, $20, $20, $20, $20, $20, $20
    !byte 6, $F, $15, $12, $20, $F, 6, $20, 1, $20, $B, 9, $E, 4, $20, $20
    !byte $13, $14, $12, 1, 9, 7, 8, $14, $20, 6, $C, $15, $13, 8, $20, $20
    !byte 6, 9, $16, 5, $20, $F, 6, $20, 1, $20, $B, 9, $E, 4, $20, $20
.ah__30000                     = $1736
.ah__30001                     = $174C
.ah__30002                     = $1765
.ah__30003                     = $17A7
.ah__30004                     = $13DB
.ah__30006                     = $1873
.ah__30008                     = $1068
.ah__30009                     = $0AFD
.ah__30010                     = $0B08
.ah__30011                     = $0B2A
.ah__30012                     = $0B35
.ah__30013                     = $0B88
.ah__30014                     = $0B93
.ah__30015                     = $0BB5
.ah__30016                     = $0BC0
.ai__00090.do__00063           = $0E92
.ai__00090.do__00066           = $0E9D
.ai__00090.do__00069           = $0EA8
.ai__00091.do__00051           = $0EC2
.ai__00091.do__00054           = $0ECD
.ai__00092.do__00057           = $0EFF
.ai__00092.do__00060           = $0F0A
.ai__00093.do__00077           = $0F24
.ai__00093.fi__00076           = $0F1D
.ai__00093.fi__00080           = $0F2D
.ai__00093.he__00073           = $0F1E
.ai__00093.wh__00072           = $0F16
.ai__00102.fi__00097           = $1513
.ai__00102.fi__00098           = $151B
.ai__00102.fi__00099           = $1523
.ai__00102.fi__00100           = $152B
.ai__00102.fi__00101           = $1532
.ai__00103.fi__00046           = $1542
.ai__00103.fi__00047           = $154A
.ai__00103.fi__00048           = $1552
.ai__00103.fi__00049           = $155A
.ai__00103.fi__00050           = $1561
.ai__00201.fi__00167           = $1309
.ai__00201.fi__00168           = $130E
.ai__00236.do__00202           = $15D2
.ai__00237.co__00208           = $15FF
.ai__00237.do__00205           = $15EE
.ai__00254.wh__00247           = $185B
.ai__00335.do__00238           = $1006
.ai__00352.wh__00033           = $081A
.ai__00352.wh__00038           = $0827
.ai__00353.do__00255           = $08B6
.ai__00354.wh__00247           = $08D6
.ai__00355.ah__30007           = $090B
.ai__00355.el__00258           = $08EF
.ai__00355.fi__00259           = $090B
.ai__00355.fi__00260           = $090B
.an__00152                     = $0C90
.cp__00252                     = $1883
.do__00001                     = $148D
.do__00004                     = $0E05
.do__00010                     = $0E46
.do__00013                     = $0E5E
.do__00021                     = $0E82
.do__00107                     = $1284
.do__00111                     = $17F4
.do__00120                     = $0C05
.do__00123                     = $0C1F
.do__00153                     = $1738
.do__00156                     = $174E
.do__00159                     = $1794
.do__00162                     = $17D4
.do__00185                     = $1379
.do__00229                     = $1654
.do__00261                     = $101A
.do__00264                     = $1035
.do__00271                     = $1072
.do__00274                     = $1096
.do__00277                     = $10B9
.do__00280                     = $11A4
.do__00283                     = $11BA
.do__00286                     = $11D0
.do__00289                     = $11E6
.do__00304                     = $0ABD
.do__00312                     = $0ADF
.do__00315                     = $0B0C
.do__00318                     = $0B48
.do__00326                     = $0B6A
.do__00329                     = $0B97
.do__00332                     = $0FAA
.do__00336                     = $0861
.do__00339                     = $0871
.el__00008                     = $0E36
.el__00017                     = $0E41
.el__00019                     = $0E7A
.el__00024                     = $0E6F
.el__00088                     = $0F45
.el__00135                     = $0CE4
.el__00137                     = $0CD9
.el__00139                     = $0CC1
.el__00142                     = $0D70
.el__00146                     = $0D9F
.el__00148                     = $0D25
.el__00165                     = $175A
.el__00171                     = $12CE
.el__00175                     = $1327
.el__00178                     = $1336
.el__00192                     = $1400
.el__00199                     = $13A8
.el__00219                     = $1829
.el__00221                     = $1834
.ew__00134                     = $0DE7
.ew__00183                     = $143F
.ew__00218                     = $1838
.fi__00007                     = $0E3E
.fi__00009                     = $0E3E
.fi__00016                     = $0E6C
.fi__00018                     = $0E6C
.fi__00020                     = $0E7C
.fi__00025                     = $0E8F
.fi__00026                     = $14DE
.fi__00081                     = $0EDF
.fi__00082                     = $0EE7
.fi__00083                     = $0EF4
.fi__00084                     = $0EF7
.fi__00085                     = $0EFD
.fi__00086                     = $0F40
.fi__00087                     = $0F4D
.fi__00089                     = $0F4D
.fi__00104                     = $1216
.fi__00105                     = $122E
.fi__00106                     = $1271
.fi__00110                     = $18D8
.fi__00114                     = $1800
.fi__00119                     = $1810
.fi__00130                     = $0C4C
.fi__00136                     = $0CE6
.fi__00138                     = $0CE6
.fi__00140                     = $0CEC
.fi__00141                     = $0D50
.fi__00143                     = $0D7D
.fi__00144                     = $0D9D
.fi__00145                     = $0DD5
.fi__00147                     = $0DDE
.fi__00149                     = $0DDE
.fi__00151                     = $0DDE
.fi__00166                     = $17DC
.fi__00169                     = $12B8
.fi__00170                     = $12E1
.fi__00172                     = $12E1
.fi__00173                     = $12EE
.fi__00174                     = $1333
.fi__00176                     = $1333
.fi__00177                     = $1340
.fi__00179                     = $1340
.fi__00184                     = $135A
.fi__00188                     = $1381
.fi__00189                     = $139F
.fi__00190                     = $13A5
.fi__00191                     = $141B
.fi__00193                     = $141B
.fi__00194                     = $141B
.fi__00196                     = $141B
.fi__00197                     = $142C
.fi__00200                     = $1439
.fi__00213                     = $0947
.fi__00214                     = $0948
.fi__00220                     = $182B
.fi__00223                     = $1851
.fi__00224                     = $159F
.fi__00226                     = $15A2
.fi__00227                     = $15AD
.fi__00232                     = $1668
.fi__00233                     = $1668
.fi__00234                     = $1668
.fi__00251                     = $188B
.fi__00253                     = $18C3
.fi__00307                     = $0ACD
.fi__00321                     = $0B58
.fp__00182                     = $1439
.he__00116                     = $1811
.he__00127                     = $0C4F
.he__00132                     = $0C7B
.he__00181                     = $134F
.he__00210                     = $0949
.he__00244                     = $0BEB
.he__00268                     = $1056
.he__00293                     = $1200
.he__00297                     = $1209
.he__00301                     = $0A53
.he__00309                     = $0B37
.he__00323                     = $0BC2
.he__00349                     = $090B
.lj80000                       = $0DF0
.lj80001                       = $12B0
.lj80002                       = $15C7
.lj80003                       = $15D2
.lj80004                       = $0B44
.lj80005                       = $0BCF
.or__00225                     = $1594
.th__00150                     = $0C93
.wh__00115                     = $1805
.wh__00126                     = $0C29
.wh__00131                     = $0C71
.wh__00180                     = $1345
.wh__00209                     = $0916
.wh__00215                     = $181B
.wh__00243                     = $0BD6
.wh__00267                     = $1045
.wh__00292                     = $11FD
.wh__00296                     = $1206
.wh__00300                     = $0A4A
.wh__00308                     = $0ADB
.wh__00322                     = $0B66
.wh__00344                     = $08C6
.wh__00348                     = $08D3
__calculate_spread$min         = $1DA0
__constant8                    = $1B10
__count_rank_groupings$i       = $0048
__mul_u8u8u8                   = $1440
__mul_u8u8u8_add               = $1444
__mul_u8u8u8_loop              = $1448
__mul_u8u8u8_start             = $144B
__no_eor                       = $147C
__rand_loop                    = $1474
__reg                          = $0043
__zeropage_end                 = $00FF
__zeropage_first               = $003D
__zeropage_last                = $00FE
__zeropage_usage               = $00C2
animate_hand_color             = $0DE8
animate_hand_color$i           = $1DA0
animation_countdown            = $1DFA
bike_direction                 = $1DA4
bike_progress                  = $1DBC
build_sprite_freezing_charset  = $0A3C
build_sprite_freezing_charset$b = $00F9
build_sprite_freezing_charset$i = $009E
build_sprite_freezing_charset$j = $00FA
build_sprite_freezing_charset$source = $00FD
build_sprite_freezing_charset$target = $00FB
calculate_sprites              = $0C00
calculate_sprites$i            = $1DA1
calculate_sprites$l            = $1DA3
calculate_sprites$mask         = $1DA2
calculate_sprites$next         = $003E
calculate_sprites$s            = $1DA0
card_exists                    = $17EF
card_exists$card               = $1DA0
char_offsets.array             = $1B5A
char_offsets2.array            = $1AD6
check_and_process_hand         = $120E
check_and_process_hand$i       = $1DA1
check_and_process_hand$type    = $1DA2
clear_card_on_screen           = $1483
clear_card_on_screen$i         = $1DB9
clear_card_on_screen$position  = $1DA2
clear_screen                   = $1015
clear_screen$i                 = $1DA2
clear_screen$p                 = $00FD
clear_screen$x                 = $1DA0
copy_sprites$i                 = $009B
countdown_until_acceleration   = $1DA6
destroy_object                 = $10AA
display_fuel                   = $1819
display_hi_score               = $094E
display_score                  = $0F50
draw_card_to_screen            = $0986
draw_card_to_screen$card       = $00F7
draw_card_to_screen$ch         = $00F8
draw_card_to_screen$position   = $004C
draw_card_to_sprite            = $16B9
draw_card_to_sprite$card       = $1DB9
draw_card_to_sprite$source     = $00FB
draw_card_to_sprite$sprite_pointer = $1DA2
draw_card_to_sprite$target     = $00FD
fuel                           = $1DBA
fuel_bar.array                 = $1B32
game_over                      = $14A6
game_over_message_offset       = $1DE7
game_speed                     = $1DA5
get_hand_type                  = $0E90
get_random_card$card           = $009F
get_y_for_lane                 = $1852
had_counts.array               = $1DD0
had_ranks.array                = $1DED
had_suits.array                = $1DB4
hand.array                     = $1DE0
hand_size                      = $1DEC
handle_input                   = $14FB
hi_put_dec_byte                = $169D
hi_put_dec_byte$at             = $1DB9
hi_put_dec_byte$b              = $1DA2
hi_score                       = $1DAF
init_game                      = $0F88
input_btn                      = $004B
input_dx                       = $1DEB
input_dy                       = $1DE6
is_game_over                   = $1DB3
last_lane                      = $1DBD
looptyloop                     = $084A
main                           = $080D
move_objects                   = $12A8
move_objects$dpos              = $00FD
move_objects$i                 = $1DA3
move_objects$pos               = $00FB
o_flying_y.array               = $18F6
o_lane.array                   = $1DA7
o_position_hi.array            = $1DC0
o_position_lo.array            = $1DFB
o_types.array                  = $1BB9
obj_to_sprite.array            = $1DC8
play_sound                     = $17DD
play_sound$addr                = $1DE8
positions_to_clear.array       = $1AE2
put_dec_byte                   = $1453
put_dec_byte$at                = $1DB9
put_dec_byte$b                 = $1DB8
rand                           = $146F
rand_seed                      = $1DBE
read_joy2$value                = $009C
restart_game                   = $1DE5
run_sound_command              = $0BD0
run_sound_command$delta        = $003D
run_sound_command$p            = $00FD
score                          = $1E05
scores.array                   = $1BA5
show_title_screen              = $10B4
show_title_screen$i            = $1DA0
snd_explosion.array            = $1B24
snd_hurry_up.array             = $197F
snd_jingle.array               = $1B79
sound_countdown                = $1DEA
sound_pointer                  = $1E09
spawn_countdown                = $1DD6
spawn_object                   = $0912
spawn_object$i                 = $0047
spawn_object$lane              = $0045
spawn_object$type              = $0046
sprite_bike_data.array         = $1BC1
sprite_rank_data.array         = $199D
sprite_reverse_data.array      = $18D9
sprite_suit_data.array         = $18FE
sprite_to_obj.array            = $1DD8
text.array                     = $1D00
title_screen_frame             = $185B
title_sprite_pos               = $1E03
touch_object                   = $18C4
txt_acceleration.array         = $1AF4
txt_copyright.array            = $1B90
txt_fuel.array                 = $18F1
txt_game_over.array            = $195F
txt_hiscore.array              = $1B11
txt_press_fire.array           = $1B66
txt_score.array                = $1BA0
txt_title.array                = $1B04
update_screen                  = $1562
    ; $003D = __zeropage_first
    ; $003D = run_sound_command$delta
    ; $003E = calculate_sprites$next
    ; $0043 = __reg
    ; $0045 = spawn_object$lane
    ; $0046 = spawn_object$type
    ; $0047 = spawn_object$i
    ; $0048 = __count_rank_groupings$i
    ; $004B = input_btn
    ; $004C = draw_card_to_screen$position
    ; $009B = copy_sprites$i
    ; $009C = read_joy2$value
    ; $009E = build_sprite_freezing_charset$i
    ; $009F = get_random_card$card
    ; $00C2 = __zeropage_usage
    ; $00F7 = draw_card_to_screen$card
    ; $00F8 = draw_card_to_screen$ch
    ; $00F9 = build_sprite_freezing_charset$b
    ; $00FA = build_sprite_freezing_charset$j
    ; $00FB = build_sprite_freezing_charset$target
    ; $00FB = draw_card_to_sprite$source
    ; $00FB = move_objects$pos
    ; $00FD = build_sprite_freezing_charset$source
    ; $00FD = clear_screen$p
    ; $00FD = draw_card_to_sprite$target
    ; $00FD = move_objects$dpos
    ; $00FD = run_sound_command$p
    ; $00FE = __zeropage_last
    ; $00FF = __zeropage_end
    ; $080D = main
    ; $081A = .ai__00352.wh__00033
    ; $0827 = .ai__00352.wh__00038
    ; $084A = looptyloop
    ; $0861 = .do__00336
    ; $0871 = .do__00339
    ; $08B6 = .ai__00353.do__00255
    ; $08C6 = .wh__00344
    ; $08D3 = .wh__00348
    ; $08D6 = .ai__00354.wh__00247
    ; $08EF = .ai__00355.el__00258
    ; $090B = .ai__00355.ah__30007
    ; $090B = .ai__00355.fi__00259
    ; $090B = .ai__00355.fi__00260
    ; $090B = .he__00349
    ; $0912 = spawn_object
    ; $0916 = .wh__00209
    ; $0947 = .fi__00213
    ; $0948 = .fi__00214
    ; $0949 = .he__00210
    ; $094E = display_hi_score
    ; $0986 = draw_card_to_screen
    ; $0A3C = build_sprite_freezing_charset
    ; $0A4A = .wh__00300
    ; $0A53 = .he__00301
    ; $0ABD = .do__00304
    ; $0ACD = .fi__00307
    ; $0ADB = .wh__00308
    ; $0ADF = .do__00312
    ; $0AFD = .ah__30009
    ; $0B08 = .ah__30010
    ; $0B0C = .do__00315
    ; $0B2A = .ah__30011
    ; $0B35 = .ah__30012
    ; $0B37 = .he__00309
    ; $0B44 = .lj80004
    ; $0B48 = .do__00318
    ; $0B58 = .fi__00321
    ; $0B66 = .wh__00322
    ; $0B6A = .do__00326
    ; $0B88 = .ah__30013
    ; $0B93 = .ah__30014
    ; $0B97 = .do__00329
    ; $0BB5 = .ah__30015
    ; $0BC0 = .ah__30016
    ; $0BC2 = .he__00323
    ; $0BCF = .lj80005
    ; $0BD0 = run_sound_command
    ; $0BD6 = .wh__00243
    ; $0BEB = .he__00244
    ; $0C00 = calculate_sprites
    ; $0C05 = .do__00120
    ; $0C1F = .do__00123
    ; $0C29 = .wh__00126
    ; $0C4C = .fi__00130
    ; $0C4F = .he__00127
    ; $0C71 = .wh__00131
    ; $0C7B = .he__00132
    ; $0C90 = .an__00152
    ; $0C93 = .th__00150
    ; $0CC1 = .el__00139
    ; $0CD9 = .el__00137
    ; $0CE4 = .el__00135
    ; $0CE6 = .fi__00136
    ; $0CE6 = .fi__00138
    ; $0CEC = .fi__00140
    ; $0D25 = .el__00148
    ; $0D50 = .fi__00141
    ; $0D70 = .el__00142
    ; $0D7D = .fi__00143
    ; $0D9D = .fi__00144
    ; $0D9F = .el__00146
    ; $0DD5 = .fi__00145
    ; $0DDE = .fi__00147
    ; $0DDE = .fi__00149
    ; $0DDE = .fi__00151
    ; $0DE7 = .ew__00134
    ; $0DE8 = animate_hand_color
    ; $0DF0 = .lj80000
    ; $0E05 = .do__00004
    ; $0E36 = .el__00008
    ; $0E3E = .fi__00007
    ; $0E3E = .fi__00009
    ; $0E41 = .el__00017
    ; $0E46 = .do__00010
    ; $0E5E = .do__00013
    ; $0E6C = .fi__00016
    ; $0E6C = .fi__00018
    ; $0E6F = .el__00024
    ; $0E7A = .el__00019
    ; $0E7C = .fi__00020
    ; $0E82 = .do__00021
    ; $0E8F = .fi__00025
    ; $0E90 = get_hand_type
    ; $0E92 = .ai__00090.do__00063
    ; $0E9D = .ai__00090.do__00066
    ; $0EA8 = .ai__00090.do__00069
    ; $0EC2 = .ai__00091.do__00051
    ; $0ECD = .ai__00091.do__00054
    ; $0EDF = .fi__00081
    ; $0EE7 = .fi__00082
    ; $0EF4 = .fi__00083
    ; $0EF7 = .fi__00084
    ; $0EFD = .fi__00085
    ; $0EFF = .ai__00092.do__00057
    ; $0F0A = .ai__00092.do__00060
    ; $0F16 = .ai__00093.wh__00072
    ; $0F1D = .ai__00093.fi__00076
    ; $0F1E = .ai__00093.he__00073
    ; $0F24 = .ai__00093.do__00077
    ; $0F2D = .ai__00093.fi__00080
    ; $0F40 = .fi__00086
    ; $0F45 = .el__00088
    ; $0F4D = .fi__00087
    ; $0F4D = .fi__00089
    ; $0F50 = display_score
    ; $0F88 = init_game
    ; $0FAA = .do__00332
    ; $1006 = .ai__00335.do__00238
    ; $1015 = clear_screen
    ; $101A = .do__00261
    ; $1035 = .do__00264
    ; $1045 = .wh__00267
    ; $1056 = .he__00268
    ; $1068 = .ah__30008
    ; $1072 = .do__00271
    ; $1096 = .do__00274
    ; $10AA = destroy_object
    ; $10B4 = show_title_screen
    ; $10B9 = .do__00277
    ; $11A4 = .do__00280
    ; $11BA = .do__00283
    ; $11D0 = .do__00286
    ; $11E6 = .do__00289
    ; $11FD = .wh__00292
    ; $1200 = .he__00293
    ; $1206 = .wh__00296
    ; $1209 = .he__00297
    ; $120E = check_and_process_hand
    ; $1216 = .fi__00104
    ; $122E = .fi__00105
    ; $1271 = .fi__00106
    ; $1284 = .do__00107
    ; $12A8 = move_objects
    ; $12B0 = .lj80001
    ; $12B8 = .fi__00169
    ; $12CE = .el__00171
    ; $12E1 = .fi__00170
    ; $12E1 = .fi__00172
    ; $12EE = .fi__00173
    ; $1309 = .ai__00201.fi__00167
    ; $130E = .ai__00201.fi__00168
    ; $1327 = .el__00175
    ; $1333 = .fi__00174
    ; $1333 = .fi__00176
    ; $1336 = .el__00178
    ; $1340 = .fi__00177
    ; $1340 = .fi__00179
    ; $1345 = .wh__00180
    ; $134F = .he__00181
    ; $135A = .fi__00184
    ; $1379 = .do__00185
    ; $1381 = .fi__00188
    ; $139F = .fi__00189
    ; $13A5 = .fi__00190
    ; $13A8 = .el__00199
    ; $13DB = .ah__30004
    ; $1400 = .el__00192
    ; $141B = .fi__00191
    ; $141B = .fi__00193
    ; $141B = .fi__00194
    ; $141B = .fi__00196
    ; $142C = .fi__00197
    ; $1439 = .fi__00200
    ; $1439 = .fp__00182
    ; $143F = .ew__00183
    ; $1440 = __mul_u8u8u8
    ; $1444 = __mul_u8u8u8_add
    ; $1448 = __mul_u8u8u8_loop
    ; $144B = __mul_u8u8u8_start
    ; $1453 = put_dec_byte
    ; $146F = rand
    ; $1474 = __rand_loop
    ; $147C = __no_eor
    ; $1483 = clear_card_on_screen
    ; $148D = .do__00001
    ; $14A6 = game_over
    ; $14DE = .fi__00026
    ; $14FB = handle_input
    ; $1513 = .ai__00102.fi__00097
    ; $151B = .ai__00102.fi__00098
    ; $1523 = .ai__00102.fi__00099
    ; $152B = .ai__00102.fi__00100
    ; $1532 = .ai__00102.fi__00101
    ; $1542 = .ai__00103.fi__00046
    ; $154A = .ai__00103.fi__00047
    ; $1552 = .ai__00103.fi__00048
    ; $155A = .ai__00103.fi__00049
    ; $1561 = .ai__00103.fi__00050
    ; $1562 = update_screen
    ; $1594 = .or__00225
    ; $159F = .fi__00224
    ; $15A2 = .fi__00226
    ; $15AD = .fi__00227
    ; $15C7 = .lj80002
    ; $15D2 = .ai__00236.do__00202
    ; $15D2 = .lj80003
    ; $15EE = .ai__00237.do__00205
    ; $15FF = .ai__00237.co__00208
    ; $1654 = .do__00229
    ; $1668 = .fi__00232
    ; $1668 = .fi__00233
    ; $1668 = .fi__00234
    ; $169D = hi_put_dec_byte
    ; $16B9 = draw_card_to_sprite
    ; $1736 = .ah__30000
    ; $1738 = .do__00153
    ; $174C = .ah__30001
    ; $174E = .do__00156
    ; $175A = .el__00165
    ; $1765 = .ah__30002
    ; $1794 = .do__00159
    ; $17A7 = .ah__30003
    ; $17D4 = .do__00162
    ; $17DC = .fi__00166
    ; $17DD = play_sound
    ; $17EF = card_exists
    ; $17F4 = .do__00111
    ; $1800 = .fi__00114
    ; $1805 = .wh__00115
    ; $1810 = .fi__00119
    ; $1811 = .he__00116
    ; $1819 = display_fuel
    ; $181B = .wh__00215
    ; $1829 = .el__00219
    ; $182B = .fi__00220
    ; $1834 = .el__00221
    ; $1838 = .ew__00218
    ; $1851 = .fi__00223
    ; $1852 = get_y_for_lane
    ; $185B = .ai__00254.wh__00247
    ; $185B = title_screen_frame
    ; $1873 = .ah__30006
    ; $1883 = .cp__00252
    ; $188B = .fi__00251
    ; $18C3 = .fi__00253
    ; $18C4 = touch_object
    ; $18D8 = .fi__00110
    ; $18D9 = sprite_reverse_data.array
    ; $18F1 = txt_fuel.array
    ; $18F6 = o_flying_y.array
    ; $18FE = sprite_suit_data.array
    ; $195F = txt_game_over.array
    ; $197F = snd_hurry_up.array
    ; $199D = sprite_rank_data.array
    ; $1AD6 = char_offsets2.array
    ; $1AE2 = positions_to_clear.array
    ; $1AF4 = txt_acceleration.array
    ; $1B04 = txt_title.array
    ; $1B10 = __constant8
    ; $1B11 = txt_hiscore.array
    ; $1B24 = snd_explosion.array
    ; $1B32 = fuel_bar.array
    ; $1B5A = char_offsets.array
    ; $1B66 = txt_press_fire.array
    ; $1B79 = snd_jingle.array
    ; $1B90 = txt_copyright.array
    ; $1BA0 = txt_score.array
    ; $1BA5 = scores.array
    ; $1BB9 = o_types.array
    ; $1BC1 = sprite_bike_data.array
    ; $1D00 = text.array
    ; $1DA0 = __calculate_spread$min
    ; $1DA0 = animate_hand_color$i
    ; $1DA0 = calculate_sprites$s
    ; $1DA0 = card_exists$card
    ; $1DA0 = clear_screen$x
    ; $1DA0 = show_title_screen$i
    ; $1DA1 = calculate_sprites$i
    ; $1DA1 = check_and_process_hand$i
    ; $1DA2 = calculate_sprites$mask
    ; $1DA2 = check_and_process_hand$type
    ; $1DA2 = clear_card_on_screen$position
    ; $1DA2 = clear_screen$i
    ; $1DA2 = draw_card_to_sprite$sprite_pointer
    ; $1DA2 = hi_put_dec_byte$b
    ; $1DA3 = calculate_sprites$l
    ; $1DA3 = move_objects$i
    ; $1DA4 = bike_direction
    ; $1DA5 = game_speed
    ; $1DA6 = countdown_until_acceleration
    ; $1DA7 = o_lane.array
    ; $1DAF = hi_score
    ; $1DB3 = is_game_over
    ; $1DB4 = had_suits.array
    ; $1DB8 = put_dec_byte$b
    ; $1DB9 = clear_card_on_screen$i
    ; $1DB9 = draw_card_to_sprite$card
    ; $1DB9 = hi_put_dec_byte$at
    ; $1DB9 = put_dec_byte$at
    ; $1DBA = fuel
    ; $1DBC = bike_progress
    ; $1DBD = last_lane
    ; $1DBE = rand_seed
    ; $1DC0 = o_position_hi.array
    ; $1DC8 = obj_to_sprite.array
    ; $1DD0 = had_counts.array
    ; $1DD6 = spawn_countdown
    ; $1DD8 = sprite_to_obj.array
    ; $1DE0 = hand.array
    ; $1DE5 = restart_game
    ; $1DE6 = input_dy
    ; $1DE7 = game_over_message_offset
    ; $1DE8 = play_sound$addr
    ; $1DEA = sound_countdown
    ; $1DEB = input_dx
    ; $1DEC = hand_size
    ; $1DED = had_ranks.array
    ; $1DFA = animation_countdown
    ; $1DFB = o_position_lo.array
    ; $1E03 = title_sprite_pos
    ; $1E05 = score
    ; $1E09 = sound_pointer