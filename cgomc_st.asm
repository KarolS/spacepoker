* = $801
_basic_loader.array
    !byte $B, 8, $A, 0, $9E, $32, $30, $36, $31, 0, 0, 0
* = $80d
main
    LDA #$7F
    STA sound_countdown
    LDA #snd_jingle + $16.lo
    STA sound_pointer
    LDA #snd_jingle + $16.hi
    STA sound_pointer + 1
    LDY #$18
.ai__00044.do__00026
    DEY 
    LDA #0
    STA $D400, Y
    TYA 
    BNE .ai__00044.do__00026
    LDA #$F
    STA $D418
    LDA #$7F
    STA sound_countdown
.wh__00035
.ai__00045.wh__00031
    LDA $D012
    CMP #$FF
    BNE .ai__00045.wh__00031
    LDA sound_countdown
    CMP #$7F
    BEQ .ai__00046.fi__00025
    LDA sound_countdown
    BEQ .ai__00046.el__00023
    DEC sound_countdown
    JMP .ai__00046.fi__00024
.ai__00046.el__00023
    LDA sound_pointer
    STA run_sound_command$p
    LDA sound_pointer + 1
    STA run_sound_command$p + 1
    JSR run_sound_command
    STX sound_countdown
    CLC 
    ADC sound_pointer
    STA sound_pointer
    BCC .ai__00046.ah__30000
    INC sound_pointer + 1
.ai__00046.ah__30000
.ai__00046.fi__00024
.ai__00046.fi__00025
    LDA sound_countdown
    CMP #$7F
    BNE .fi__00043
    LDA #$E
    STA $D020
    JSR handle_input
    LDA input_dx
    BPL .fi__00039
    LDA #2
    STA $D020
    LDA #snd_explosion.lo
    STA play_sound$addr
    LDA #snd_explosion.hi
    STA play_sound$addr + 1
    JSR play_sound
.fi__00039
    LDA input_dx
    CMP #0
    BMI .fi__00040
    BEQ .fi__00040
    LDA #1
    STA $D020
    LDA #snd_jingle.lo
    STA play_sound$addr
    LDA #snd_jingle.hi
    STA play_sound$addr + 1
    JSR play_sound
.fi__00040
    LDA input_dy
    CMP #0
    BMI .fi__00041
    BEQ .fi__00041
    LDA #7
    STA $D020
    LDA #snd_hurry_up.lo
    STA play_sound$addr
    LDA #snd_hurry_up.hi
    STA play_sound$addr + 1
    JSR play_sound
.fi__00041
    LDA input_dy
    BPL .fi__00042
    LDA #5
    STA $D020
.fi__00042
.fi__00043
    JMP .wh__00035
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $8b8
run_sound_command
    LDA #0
    STA run_sound_command$delta
    BEQ .he__00010
.wh__00009
    LDA run_sound_command$delta
    CLC 
    ADC #1
    TAY 
    LDA (run_sound_command$p), Y
    PHA 
    LDY run_sound_command$delta
    LDA (run_sound_command$p), Y
    TAY 
    PLA 
    STA $D400, Y
    LDA run_sound_command$delta
    CLC 
    ADC #2
    STA run_sound_command$delta
.he__00010
    LDY run_sound_command$delta
    LDA (run_sound_command$p), Y
    BPL .wh__00009
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
* = $8ec
handle_input
    LDA #0
    STA input_dx
    STA input_dy
    STA input_btn
    STA $DC02
    LDA $DC00
    TAY 
    AND #1
    BNE .ai__00021.fi__00004
    DEC input_dy
.ai__00021.fi__00004
    TYA 
    AND #2
    BNE .ai__00021.fi__00005
    INC input_dy
.ai__00021.fi__00005
    TYA 
    AND #4
    BNE .ai__00021.fi__00006
    DEC input_dx
.ai__00021.fi__00006
    TYA 
    AND #8
    BNE .ai__00021.fi__00007
    INC input_dx
.ai__00021.fi__00007
    TYA 
    AND #$10
    BNE .ai__00021.fi__00008
    INC input_btn
.ai__00021.fi__00008
    LDA #0
    STA $DC03
    LDA $DC01
    TAY 
    AND #1
    BNE .ai__00022.fi__00016
    DEC input_dy
.ai__00022.fi__00016
    TYA 
    AND #2
    BNE .ai__00022.fi__00017
    INC input_dy
.ai__00022.fi__00017
    TYA 
    AND #4
    BNE .ai__00022.fi__00018
    DEC input_dx
.ai__00022.fi__00018
    TYA 
    AND #8
    BNE .ai__00022.fi__00019
    INC input_dx
.ai__00022.fi__00019
    TYA 
    AND #$10
    BNE .ai__00022.fi__00020
    INC input_btn
.ai__00022.fi__00020
    ; DISCARD_AF
    ; DISCARD_XF
    ; DISCARD_YF
    RTS 
* = $949
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
* = $956
snd_hurry_up.array
    !byte $A, 8, $B, $10, 7, $AE, 8, $20, $C, 0, $D, $E0, $B, $11, $88, $B
    !byte $10, $83, $B, $11, $88, $B, $10, $83, $B, $11, $88, $B, $10, $FF
* = $974
__constant8
    !byte 8
* = $975
snd_explosion.array
    !byte 7, 5, 8, 5, $C, $12, $D, $AD, $B, $81, $99, $B, $80, $FF
* = $983
snd_jingle.array
    !byte $B, $10, $A, 8, 7, $22, 8, $22, $C, $11, $D, $E3, $B, $11, $82, 7
    !byte $33, 8, $33, $82, $B, $10, $FF
.ai__00021.fi__00004           = $0901
.ai__00021.fi__00005           = $0908
.ai__00021.fi__00006           = $090F
.ai__00021.fi__00007           = $0916
.ai__00021.fi__00008           = $091D
.ai__00022.fi__00016           = $092C
.ai__00022.fi__00017           = $0933
.ai__00022.fi__00018           = $093A
.ai__00022.fi__00019           = $0941
.ai__00022.fi__00020           = $0948
.ai__00044.do__00026           = $081B
.ai__00045.wh__00031           = $082D
.ai__00046.ah__30000           = $0859
.ai__00046.el__00023           = $0843
.ai__00046.fi__00024           = $0859
.ai__00046.fi__00025           = $0859
.fi__00039                     = $087B
.fi__00040                     = $0893
.fi__00041                     = $08AB
.fi__00042                     = $08B4
.fi__00043                     = $08B4
.he__00010                     = $08D7
.wh__00009                     = $08BE
.wh__00035                     = $082D
__constant8                    = $0974
__reg                          = $00FD
__zeropage_end                 = $00FF
__zeropage_first               = $003F
__zeropage_last                = $00FE
__zeropage_usage               = $00C0
handle_input                   = $08EC
init_sound$i                   = $0048
input_btn                      = $0043
input_dx                       = $00F7
input_dy                       = $004B
main                           = $080D
play_sound                     = $0949
play_sound$addr                = $00FB
read_joy1$value                = $0047
read_joy2$value                = $0044
run_sound_command              = $08B8
run_sound_command$delta        = $0045
run_sound_command$p            = $00FB
snd_explosion.array            = $0975
snd_hurry_up.array             = $0956
snd_jingle.array               = $0983
sound_countdown                = $004C
sound_engine_frame$delta       = $0046
sound_pointer                  = $00F8
    ; $003F = __zeropage_first
    ; $0043 = input_btn
    ; $0044 = read_joy2$value
    ; $0045 = run_sound_command$delta
    ; $0046 = sound_engine_frame$delta
    ; $0047 = read_joy1$value
    ; $0048 = init_sound$i
    ; $004B = input_dy
    ; $004C = sound_countdown
    ; $00C0 = __zeropage_usage
    ; $00F7 = input_dx
    ; $00F8 = sound_pointer
    ; $00FB = play_sound$addr
    ; $00FB = run_sound_command$p
    ; $00FD = __reg
    ; $00FE = __zeropage_last
    ; $00FF = __zeropage_end
    ; $080D = main
    ; $081B = .ai__00044.do__00026
    ; $082D = .ai__00045.wh__00031
    ; $082D = .wh__00035
    ; $0843 = .ai__00046.el__00023
    ; $0859 = .ai__00046.ah__30000
    ; $0859 = .ai__00046.fi__00024
    ; $0859 = .ai__00046.fi__00025
    ; $087B = .fi__00039
    ; $0893 = .fi__00040
    ; $08AB = .fi__00041
    ; $08B4 = .fi__00042
    ; $08B4 = .fi__00043
    ; $08B8 = run_sound_command
    ; $08BE = .wh__00009
    ; $08D7 = .he__00010
    ; $08EC = handle_input
    ; $0901 = .ai__00021.fi__00004
    ; $0908 = .ai__00021.fi__00005
    ; $090F = .ai__00021.fi__00006
    ; $0916 = .ai__00021.fi__00007
    ; $091D = .ai__00021.fi__00008
    ; $092C = .ai__00022.fi__00016
    ; $0933 = .ai__00022.fi__00017
    ; $093A = .ai__00022.fi__00018
    ; $0941 = .ai__00022.fi__00019
    ; $0948 = .ai__00022.fi__00020
    ; $0949 = play_sound
    ; $0956 = snd_hurry_up.array
    ; $0974 = __constant8
    ; $0975 = snd_explosion.array
    ; $0983 = snd_jingle.array