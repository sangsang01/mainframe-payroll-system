PAGRSS    DC    PL7'0'         AVERAGE GROSS                           00083004            
PTFWTH    DC    PL7'0'         TOTAL FEDEREAL WITHOLDING               00084004            
PAFWTH    DC    PL7'0'         AVERAGE FEDEREAL WITHOLDING             00085004            
PTSWTH    DC    PL7'0'         TOTAL STATE WITHOLDING                  00086004            
PASWTH    DC    PL7'0'         AVERAGE STATE WITHOLDING                00087004            
PTNP      DC    PL7'0'         TOTAL NET                               00088004            
PANP      DC    PL7'0'         AVERAGE NET                             00089004            
***********MAIN PROGRAM*********************************************** 00090000            
AYROLL    CSECT                                                        00100004            
          STM   14,12,12(13)                                           00110004            
          LR    12,15                                                  00120004            
          USING PAYROLL,12                                             00130004            
          LA    14,MAINSAVE                                            00140004            
          ST    13,4(,14)                                              00150004            
          ST    14,8(,13)                                              00160004            
          LR    13,14                                                  00170004            
CALL THE BUILD TABLE                                                   00180008            
          LA    1,BTPARMS          CALL THE BULD TABLE PARAMS          00190004            
          L     15,=V(BUILDTBL)    CALL THE SUBPROGRAM                 00200004            
          BALR  14,15                                                  00210000            
CALL THE PROCTABL                                                      00220008            
          LA    1,PTPARMS                                              00230008            
          L     15,=V(PROCTBL)                                         00231008            
          BALR  14,15                                                  00232008            
CALL THE PRNTTABL                                                      00233008            
          LA    1,PRNPARM                                              00234008            
          L     15,=V(PRNTTABL)                                        00235008            
          BALR  14,15                                                  00236008            
CALL THE PRNTTABL                                                      00237014            
          LA    1,PRNSPAR                                              00238014            
          L     15,=V(PRNTSUMR)                                        00239014            
          BALR  14,15                                                  00240014            
 ==== EXIT LINKAGE ============                                        00241014            
          LA    15,0                                                   00250014            
          L     13,4(,13)                                              00260004            
          L     14,12(,13)                                             00270004            
          LM    0,12,20(13)                                            00280004            
          BR    14                                                     00290004            
          LTORG                                                        00300004            
              =V(BUILDTBL)                                                                 
              =V(PROCTBL)                                                                  
              =V(PRNTTABL)                                                                 
              =V(PRNTSUMR)                                                                 
*********MAIN PROGRAM STORAGE*************************************     00310001            
AINSAVE   DC  18F'-1'                                                  00320001            
                                                                       00330000            
FWHPCT    DC  PL4'0'      STORE RATE OF THE FEDERAL                    00340001            
SWHPCT    DC  PL4'0'      STORE RATE OF THE STATE                      00350001            
EMPCTR    DC  PL3'0'      STORE THE EMPLOYEE COUNT                     00360001            
                                                                       00361000            

                                                                      PAGE    2            

 SOURCE STATEMENT                                                                          
UMSTRCT   DC    PL7'0'                                                 00361105            
          DC    PL7'0'                                                 00361205            
          DC    PL7'0'                                                 00361305            
          DC    PL7'0'                                                 00361405            
          DC    PL7'0'                                                 00361505            
          DC    PL7'0'                                                 00361605            
          DC    PL7'0'                                                 00361705            
          DC    PL7'0'                                                 00361805            
PASSING THE PARAMETER TO PROCESS THE BUILD TABLE FUNCTION              00362003            
TPARMS    DC  A(PFWHPCT,PSWHPCT,EMPTBL,TBLEND,PEMPCTR)                 00363005            
                                                                       00364003            
PASSING THE PARAMETER TO PROCESS THE TABLE                             00365004            
TPARMS    DC  A(PFWHPCT,PSWHPCT,EMPTBL,PEMPCTR,SUMSTRCT)               00366005            
                                                                       00367008            
PASSING THE PARAMETER TO PRINT THE TABLE                               00368008            
RNPARM    DC  A(EMPTBL,PEMPCTR)                                        00369013            
                                                                       00370008            
PASSING THE PARAMETER TO PRINT THE SUMMARY                             00380014            
RNSPAR    DC  A(SUMSTRCT)                                              00390014            
                                                                       00391014            
MPTBL     DS  117CL65     SIZE OF THE TABLE                            00400005            
BLEND     DS  0C          TRAIL TABLE                                  00410005            
                                                                       00411001            
*****************************************************************      00420000            
                 BUILDS EMPLOYEE DATA TABLE                     *      00430000            
*****************************************************************      00440000            
WTHOLD    DSECT                                                        00450000            
SRATE     DS    ZL6                                                    00460000            
FRATE     DS    ZL6                                                    00470000            
*********************************************************************  00480000            
TTABLE    DSECT                                                        00490000            
ID        DC    PL5'0'      (INPUT FOR ID)                             00500000            
RATE      DC    PL3'0'      (INPUT FOR HOUR RATE)                      00510000            
HWORK     DC    PL3'0'      (INPUT FOR HOUR WORKED)                    00520000            
DEDUC     DC    PL3'0'      (INPUT FOR DEDUCTION AMOUNT)               00530000            
BONUS     DC    PL3'0'      (INPUTH FOR THE BONUS AMOUNT)              00540000            
NAME      DS    CL24        (NAME OF THE EMPLOYEE)                     00550000            
GPAY      DS    PL6'0'      (GROSS PAY FOR THE EMPLOYEE)               00560000            
FWITH     DS    PL6'0'      (FED WITHOLDING)                           00570000            
SWITH     DS    PL6'0'      (STATE WITHOLDING)                         00580000            
NPAY      DS    PL6'0'      (NET PAY)                                  00590000            
*********************************************************************  00600000            
INREC     DSECT                                                        00610000            
IID       DS    ZL8         (INPUT FOR ID)                             00620000            
IRATE     DS    ZL5         (INPUT FOR HOUR RATE)                      00630000            
IHWORK    DS    ZL5         (INPUT FOR HOUR WORKED)                    00640000            
IDEDUC    DS    ZL5         (INPUT FOR DEDUCTION AMOUNT)               00650000            
IBONUS    DS    ZL5         (INPUTH FOR THE BONUS AMOUNT)              00660000            
INAME     DS    CL24        (NAME OF THE EMPLOYEE)                     00670000            
********************************************************************** 00680000            
UILDTBL   CSECT                                                        00690004            
 ==== ENTRY LINKAGE ===========                                        00700000            
          STM   14,12,12(13)                                           00710004            
          LR    12,15                                                  00720004            
          USING BUILDTBL,12                                            00730004            
          LA    14,BLDSAVE                                             00740004            
          ST    13,4(,14)                                              00750004            

                                                                      PAGE    3            

 SOURCE STATEMENT                                                                          
          ST    14,8(,13)                                              00760004            
          LR    13,14                                                  00770004            
START DEREF PARAM LIST                                                 00780000            
          LM    2,6,0(1)                                               00790000            
                               R2: FEDERAL WITHOLDING RATE             00800000            
                               R3: STATE WITHOLDING RATE               00810000            
                               R4: TABLE ADDRESS                       00820000            
                               R5: TABLE END ADDRESS                   00830000            
                               R6: EMPLOYEE COUNTER                    00840000            
          LA    7,BUFFER       LOAD THE BUFFER                         00850000            
          USING $WTHOLD,7      USING THE DSECT                         00860000            
          XREAD BUFFER,80                                              00870000            
          PACK  0(4,2),0(6,7)  PACK SIX BYTES INTO PFWHPCT             00880000            
          PACK  0(4,3),6(6,7)  PACK NEXT SIX BYTES INTO PSWHPCT        00890013            
          DROP  7              DONE USING R7                           00900000            
          USING $TTABLE,4      USING LABEL FOR TABLE                   00910010            
          USING $INREC,7       USING LABEL FOR BUFFER                  00920010            
          XREAD BUFFER,80                                              00930000            
LDLOOP    BNZ   ENDBLD                                                 00940000            
          AP    0(3,6),=PL1'1'         ADD ONE TO THE COUNTER          00950003            
          PACK  $ID(5),$IID(8)                                         00960012            
          PACK  $RATE(3),$IRATE(5)                                     00970012            
          PACK  $HWORK(3),$IHWORK(5)                                   00980012            
          PACK  $DEDUC(3),$IDEDUC(5)                                   00990012            
          PACK  $BONUS(3),$IBONUS(5)                                   01000012            
          MVC   $NAME(24),BUFFER+28                                    01010012            
          CR    4,5                    COMPARE THE SIZE OF THE TABLE   01020000            
          BNL   ENDBLD                 BRANCH OUT IF THE SIZE MEET     01030000            
          LA    4,65(0,4)              LOAD THE NEW LINE               01040000            
          XREAD BUFFER,80              PROCESS NEW RECORD              01050003            
          B     BLDLOOP                                                01060000            
 ==== EXIT LINKAGE ============                                        01070000            
NDBLD     DS    0H                                                     01071010            
          DROP  4                                                      01072010            
          DROP  7                                                      01073010            
          L     13,4(,13)                                              01080010            
          L     14,12(,13)                                             01090004            
          LM    0,12,20(13)                                            01100004            
          BR    14                                                     01110004            
          LTORG                                                        01120000            
              =PL1'1'                                                                      
*********BUILDTBL PROGRAM STORAGE**********************************    01130001            
LDSAVE    DC    18F'-1'                                                01140000            
UFFER     DS    CL80                                                   01141003            
                                                                       01150000            
*****************************************************************      01160004            
                PROCESSING THE TABLE                            *      01161004            
*****************************************************************      01162004            
ROCTBL    CSECT                                                        01163004            
 ==== ENTRY LINKAGE ===========                                        01164004            
          STM   14,12,12(13)                                           01165004            
          LR    12,15                                                  01166004            
          USING PROCTBL,12                                             01167004            
          LA    14,PROCSAVE                                            01168004            
          ST    13,4(,14)                                              01169004            
          ST    14,8(,13)                                              01169104            
          LR    13,14                                                  01169204            

                                                                      PAGE    4            

 SOURCE STATEMENT                                                                          
DEREFERENCE THE PARAMETER                                              01169304            
          LM    2,6,0(1)                                               01169404            
R2:  FEDERAL WITHOLDING RATE                                           01169504            
R3:  STATE WITHOLDING RATE                                             01169604            
R4:  EMPLOYEE TABLE                                                    01169704            
R5:  EMPCTR                                                            01169804            
R6:  HOLDING THE DSECT TO CALCULATE THE SUMMARY                        01169904            
          USING $TTABLE,4                                              01170212            
          USING $SUMMARY,6                                             01170312            
          SP    0(3,5),=PL1'1'                                         01170613            
          CP    0(3,5),=PL1'1'                                         01170713            
          BZ    PROCAVG                                                01170913            
ROCLOOP   ZAP   PEMPGPAY(6),$RATE(3)                                   01171113            
          MP    PEMPGPAY(6),$HWORK(3)                                  01171213            
          SRP   PEMPGPAY(6),64-2,5             ROUND THE VALUE         01171304            
          SP    PEMPGPAY(6),$DEDUC(3)          SUBTRACT THE DEDUC      01171413            
          AP    PEMPGPAY(6),$BONUS(3)          ADD WITH THE BONUS      01171513            
          MVC   $GPAY(6),PEMPGPAY              STORE TO THE TABLE      01171613            
          LA    1,CNPPARMS                     LOAD THE LIST PRAMS     01171704            
          L     15,=V(CALCNPAY)                CALL THE PROGRAM        01171805            
          BALR  14,15                                                  01171904            
STORE THE DATA OF THE EMPLOYEE INTO THE TABLE                          01172004            
          ZAP   $FWITH(6),PFEDWITH                                     01172104            
          ZAP   $SWITH(6),PSTWITH                                      01172204            
          ZAP   $NPAY(6),PEMPNPAY                                      01172304            
CALCULATE THE TOTAL FOR THE SUMSTRCT                                   01172406            
          AP    $PTGRSS(7),PEMPGPAY(6)     ADD TO TOTAL GROSS          01172506            
          AP    $PTFWTH(7),PFEDWITH(6)     ADD TO TOTAL FEDERAL        01172606            
          AP    $PTSWTH(7),PFEDWITH(6)     ADD TO TOTAL STATE          01172706            
          AP    $PTNP(7),PEMPNPAY          ADD TO TOTAL NET PAY        01172813            
          SP    0(3,5),=PL1'1'                                         01172913            
          CP    0(3,5),=PL1'0'                                         01173013            
          BE    PROCAVG                                                01173113            
          LA    4,65(0,4)                  LOAD THE NEW ROW            01173208            
          B     PROCLOOP                                               01173308            
ROCAVG    DS    0H                                                     01173406            
          DROP  4                                                      01173506            
          USING $SUMMARY,6                                             01173606            
          ZAP   PTOTAL(7),$PTGRSS(7)                                   01173706            
          LA    1,CAVGPARM                                             01173807            
          L     15,=V(CALCAVG)                                         01173906            
          BALR  14,15                                                  01174006            
          ZAP   $PAGRSS(7),PAVG(7)                                     01174106            
          ZAP   PTOTAL(7),$PTFWTH(7)                                   01174206            
          LA    1,CAVGPARM                                             01174307            
          L     15,=V(CALCAVG)                                         01174406            
          BALR  14,15                                                  01174506            
          ZAP   $PAFWTH(7),PAVG(7)                                     01174606            
          ZAP   PTOTAL(7),$PTSWTH(7)                                   01174706            
          LA    1,CAVGPARM                                             01174807            
          L     15,=V(CALCAVG)                                         01174906            
          BALR  14,15                                                  01175006            
          ZAP   $PASWTH(7),PAVG(7)                                     01175106            
          ZAP   PTOTAL(7),$PTNP                                        01175206            
          LA    1,CAVGPARM                                             01175307            
          L     15,=V(CALCAVG)                                         01175406            
          BALR  14,15                                                  01175506            

                                                                      PAGE    5            

 SOURCE STATEMENT                                                                          
          ZAP   $PANP(7),PAVG(7)                                       01175606            
          DROP  6                                                      01175706            
 ==== EXIT LINKAGE ===========                                         01175804            
          L     13,4(,13)                                              01175904            
          L     14,12(,13)                                             01176004            
          LM    0,12,20(13)                                            01176104            
          BR    14                                                     01176204            
          LTORG                                                        01176304            
              =V(CALCNPAY)                                                                 
              =V(CALCAVG)                                                                  
              =PL1'1'                                                                      
              =PL1'0'                                                                      
********PROC PROGRAM STORAGE****************************************   01176407            
ROCSAVE   DS    18F'-1'                                                01176504            
EMPGPAY   DC    PL6'0'         GROSS PAY                               01176612            
EMPNPAY   DC    PL6'0'         NET PAY                                 01176706            
FEDWITH   DC    PL6'0'         AMOUNT OF FEDERAL WITHOLDING            01176806            
STWITH    DC    PL6'0'         AMOUNT OF STATE WITHOLDING              01176906            
TEMP2     DC    PL6'0'                                                 01177012            
                                                                       01177106            
TOTAL     DC    PL7'0'         TOTAL VARIABLE                          01177206            
AVG       DC    PL7'0'         AVG VARIABLE                            01177306            
LOADING THE PARAMETER LIST FOR CALCNPAY                                01177404            
NPPARMS   DC    A(PEMPGPAY)                                            01177513            
          DC    A(PEMPNPAY)                                            01177613            
          DC    A(PFWHPCT)                                             01177713            
          DC    A(PFEDWITH)                                            01177813            
          DC    A(PSWHPCT)                                             01177913            
          DC    A(PSTWITH)                                             01178013            
                                                                       01178104            
LOADING THE PARAMETER LIST FOR CALCAVG                                 01178206            
AVGPARM   DC    A(PTOTAL)      TOTAL VARIABLE                          01178307            
          DC    A(PEMPCTR)     EMPLOYEE COUNTER                        01178407            
          DC    A(PAVG)        AVG VARIABLE                            01178507            
                                                                       01178606            
*****************************************************************      01178704            
                CALCULATE THE NET PAY                           *      01178804            
*****************************************************************      01178904            
ALCNPAY   CSECT                                                        01179004            
 ==== ENTRY LINKAGE ===========                                        01179104            
          STM   14,12,12(13)                                           01179204            
          LR    12,15                                                  01179304            
          USING CALCNPAY,12                                            01179405            
          LA    14,CALCSAVE                                            01179505            
          ST    13,4(,14)                                              01179604            
          ST    14,8(,13)                                              01179704            
          LR    13,14                                                  01179804            
START DEREF PARAM LIST                                                 01179904            
          LM    2,7,0(1)                                               01180004            
R2: PEMPGPAY   GROSS PAY                                               01180104            
R3: PEMPNPAY   NET PAY                                                 01180204            
R4: PFWHPCT    FEDERAL RATE                                            01180304            
R5: PFEDWITH   FEDERAL WITH AMOUNT                                     01180404            
R6: PSWHPCT    STATE RATE                                              01180504            
R7: PSTWITH    STATE WITH AMOUNT                                       01180604            
*************FEDERAL WITHOLDING********************                    01180704            
          ZAP   PTEMP(12),0(6,2)       GET THE GROSS PAY               01180804            

                                                                      PAGE    6            

 SOURCE STATEMENT                                                                          
          MP    PTEMP,0(4,4)           MULTIPLY WITH FED RATE          01180904            
          SRP   PTEMP,64-5,5           ROUND THE TEMP                  01181004            
          MVC   0(6,7),PTEMP+6         STORE TO VARIABLE               01181113            
*************SEDERAL WITHOLDING**************************              01181213            
          ZAP   PTEMP(12),0(6,2)       GET THE GROSS PAY               01181304            
          MP    PTEMP(12),0(4,6)       MULTIPLY WITH FED RATE          01181413            
          SRP   PTEMP,64-5,5           ROUND THE TEMP                  01181504            
          MVC   0(6,5),PTEMP+6         STORE TO VARIABLE               01181613            
**************NET PAY*********************************                 01181704            
          ZAP   0(6,3),0(6,2)          GET THE GROSS PAY               01181804            
          SP    0(6,3),0(6,5)          SUBTRACT WITH FEDWITH           01181904            
          SP    0(6,3),0(6,7)          SUBTRACT WITH STATEWITH         01182004            
 ==== EXIT LINKAGE ====================================                01182104            
          LA    15,0                                                   01182204            
          L     13,4(,13)                                              01182304            
          L     14,12(,13)                                             01182404            
          LM    0,12,20(13)                                            01182504            
          BR    14                                                     01182604            
          LTORG                                                        01182704            
************CALC STOREGAE*******************************               01182804            
ALCSAVE   DS    18F'-1'                                                01182904            
TEMP      DC    PL12'0'                                                01183004            
******************************************************************     01183106            
                    CALCULATE THE AVERAGE                        *     01183206            
******************************************************************     01183306            
ALCAVG    CSECT                                                        01183406            
 ==== ENTRY LINKAGE ===========                                        01183506            
          STM   14,12,12(13)                                           01183606            
          LR    12,15                                                  01183706            
          USING CALCAVG,12                                             01183806            
          LA    14,AVGSAVE                                             01183906            
          ST    13,4(,14)                                              01184006            
          ST    14,8(,13)                                              01184106            
          LR    13,14                                                  01184206            
DEREFERENCE THE LIST OF PARAMETER                                      01184306            
          LM    2,4,0(1)              LOAD THE PARAMETER               01184406            
R2: PTOTAL REPRESENT THE TOTAL                                         01184506            
R3: PEMPCTR EMPLOYEE COUNTER                                           01184606            
R4: PAVG HOLD THE REUSLT                                               01184706            
          ZAP   PTEMP1(10),0(7,2)     LOAD THE TOTAL TO THE TEMP       01184907            
          SRP   PTEMP1(10),3,0        SHIFT TO LEFT                    01185006            
          DP    PTEMP1(10),=PL3'117'                                   01185114            
          SRP   PTEMP1(7),64-3,5      SHIFT BACK TO THE RIGH           01185206            
          ZAP   0(7,4),PTEMP1(7)      COPY THE PAVG BACK               01185306            
 ==== EXIT LINKAGE ============                                        01185406            
          L     13,4(,13)      POINT R13 TO CALLER'S SAVE AREA         01185506            
          L     14,12(,13)     RESTORE REGISTER 14                     01185606            
          LM    0,12,20(13)    RESTORE R0 THRU R12                     01185706            
          BR    14             RETURN TO CALLER                        01185806            
          LTORG                                                        01185906            
              =PL3'117'                                                                    
*********CALCAVG PROGRAM STORAGE*****************************          01186006            
VGSAVE    DS    18F'-1'                                                01186106            
TEMP1     DC    PL10'0'                                                01186206            
                                                                       01186408            
******************************************************************     01186508            
                    PRINT THE TABLE                              *     01186608            

                                                                      PAGE    7            

 SOURCE STATEMENT                                                                          
******************************************************************     01186708            
RNTTABL   CSECT                                                        01187013            
==== ENTRY LINKAGE ===========                                         01187113            
          STM   14,12,12(13)                                           01187208            
          LR    12,15                                                  01187308            
          USING PRNTTABL,12                                            01187408            
          LA    14,PRTSAVE                                             01187508            
          ST    13,4(,14)                                              01187608            
          ST    14,8(,13)                                              01187708            
          LR    13,14                                                  01187808            
DEREFERENCE THE LIST OF PARAMETER                                      01187908            
          LM    2,3,0(1)                                               01188008            
                          R2: ADDRESS OF THE TABLE                     01188108            
                          R3: EMPLOYEE COUNTER                         01188208            
          USING $TTABLE,2                                              01188408            
          LA    4,117                                                  01188513            
          ZAP   0(3,3),=PL3'117'                                       01188614            
          MVC   OEMPCTR(6),=X'402020202120'                            01188714            
          ED    OEMPCTR(6),0(3)                                        01188814            
EADER     AP    PAGECNT(2),=PL1'1'                                     01188914            
          MVC   OPAGECTR(4),=X'40202120'                               01189008            
          ED    OPAGECTR(4),PAGECNT                                    01189108            
          LA    5,19                                                   01189208            
          XPRNT LINE1,133                                              01189308            
          XPRNT LINE2,133                                              01189408            
          XPRNT LINE3,133                                              01189508            
          XPRNT LINE4,133                                              01189608            
          XPRNT LINE5,133                                              01189713            
RTLOOP    DS    0H                                                     01189808            
          BCTR  5,0                                                    01189908            
          BCTR  4,0                                                    01190013            
********NAME & ID**********************************                    01190108            
          MVC   OEMID(9),=X'212020202020202020'                        01190208            
          ED    OEMID(9),$ID                                           01190308            
          MVC   OEMID(2),OEMID+1                                       01190408            
          MVI   OEMID+2,C'-'                                           01190508            
          MVC   OEMNAME(24),$NAME                                      01190608            
********PAY RATE**********************************                     01190708            
          LA    1,OEMRATE+3                                            01190808            
          MVC   OEMRATE(7),=X'402021204B2020'                          01190908            
          EDMK  OEMRATE(7),$RATE                                       01191008            
          BCTR  1,0                                                    01191108            
          MVI   0(1),C'$'                                              01191208            
********HOURS**************************************                    01191308            
          MVC   OHOURS(7),=X'402021204B2020'                           01191408            
          EDMK  OHOURS(7),$HWORK                                       01191508            
*****GROSS PAY*************************************                    01191608            
          LA    1,OGROSS+11                                            01191708            
          MVC   OGROSS(15),=X'402020206B2020206B2021204B2020'          01191808            
          EDMK  OGROSS(15),$GPAY                                       01191908            
          BCTR  1,0                                                    01192008            
          MVI   0(1),C'$'                                              01192108            
********FED WITHOLDING******************************                   01192208            
          LA    1,OFEDWH+10                                            01192308            
          MVC   OFEDWH(15),=X'402020206B2020206B2021204B2020'          01192408            
          EDMK  OFEDWH(15),$FWITH                                      01192508            
          BCTR  1,0                                                    01192608            

                                                                      PAGE    8            

 SOURCE STATEMENT                                                                          
          MVI   0(1),C'$'                                              01192708            
********STATE WITHOLDING***************************                    01192808            
          LA    1,OSTWH+10                                             01192908            
          MVC   OSTWH(15),=X'402020206B2020206B2021204B2020'           01193008            
          EDMK  OSTWH(15),$SWITH                                       01193108            
          BCTR  1,0                                                    01193208            
          MVI   0(1),C'$'                                              01193308            
********NET PAY***********************************                     01193408            
          LA    1,ONETPAY+11                                           01193508            
          MVC   ONETPAY(15),=X'402020206B2020206B2021204B2020'         01193608            
          EDMK  ONETPAY(15),$NPAY                                      01193708            
          BCTR  1,0                                                    01193808            
          MVI   0(1),C'$'                                              01193908            
          XPRNT INFO,133                                               01194008            
          SP    0(3,3),=PL1'1'                                         01194213            
          CP    0(3,3),=PL1'0'                                         01194313            
          BE    PRTDONE                                                01194413            
          LA    2,65(0,2)                                              01194513            
          C     4,=F'0'                                                01194613            
          BE    PRTDONE                                                01194713            
          C     5,=F'0'                                                01194813            
          BE    HEADER                                                 01194908            
          B     PRTLOOP                                                01195008            
 ==== EXIT LINKAGE ============                                        01195108            
RTDONE    DS    0H                                                     01195208            
          DROP  2                                                      01195308            
          AP    PAGECNT(2),=PL1'1'                                     01195414            
          MVC   OPAGECTR(4),=X'40202120'                               01195514            
          ED    OPAGECTR(4),PAGECNT                                    01195614            
          MVC   OEMPCTR(6),=X'402020202120'                            01195714            
          ED    OEMPCTR(6),0(3)                                        01195814            
          XPRNT LINE1,133                                              01195914            
          XPRNT LINE2,133                                              01196014            
          XPRNT LINE6,133                                              01196114            
          XPRNT TOTAL1,133                                             01196214            
          L     13,4(,13)      POINT R13 TO CALLER'S SAVE AREA         01196308            
          L     14,12(,13)                                             01196408            
          LM    0,12,20(13)                                            01196508            
          BR    14                                                     01196608            
          LTORG                                                        01196708            
              =X'40202120'                                                                 
              =F'0'                                                                        
              =X'402020202120'                                                             
              =PL3'117'                                                                    
              =PL1'1'                                                                      
              =X'212020202020202020'                                                       
              =X'402021204B2020'                                                           
              =X'402020206B2020206B2021204B2020'                                           
*********CALCAVG PROGRAM STORAGE*************************              01196808            
RTSAVE    DS    18F'-1'                                                01196908            
AGECNT    DC    PL2'0'                                                 01197008            
***********LINE 1****************************************              01197108            
INE1      DC    C'1'                                                   01197208            
          DC    46C' '                                                 01197308            
          DC    CL29'CHICAGO SOFTWARE COMPANY, INC'                    01197408            
          DC    47C' '                                                 01197508            
          DC    CL5'PAGE:'                                             01197608            

                                                                      PAGE    9            

 SOURCE STATEMENT                                                                          
          DC    C' '                                                   01197708            
PAGECTR   DS    CL4                                                    01197808            
*********LINE 2*******************************************             01197908            
INE2      DC    C' '                                                   01198008            
          DC    50C' '                                                 01198108            
          DC    CL23'EMPLOYEE PAYROLL REPORT'                          01198208            
          DC    60C' '                                                 01198308            
*********LINE 3*********************************************           01198408            
INE3      DC    C' '                                                   01198508            
          DC    CL8'EMPLOYEE'                                          01198608            
          DC    3C' '                                                  01198708            
          DC    CL8'EMPLOYEE'                                          01198808            
          DC    21C' '                                                 01198908            
          DC    CL6'HOURLY'                                            01199008            
          DC    5C' '                                                  01199108            
          DC    CL5'HOURS'                                             01199208            
          DC    12C' '                                                 01199308            
          DC    CL8'EMPLOYEE'                                          01199408            
          DC    4C' '                                                  01199508            
          DC    CL16'EMPLOYEE FEDERAL'                                 01199608            
          DC    4C' '                                                  01199708            
          DC    CL14'EMPLOYEE STATE'                                   01199808            
          DC    10C' '                                                 01199908            
          DC    CL8'EMPLOYEE'                                          01200008            
          DC    2C' '                                                  01200108            
*********LINE 4**********************************************          01200208            
INE4      DC    C' '                                                   01200308            
          DC    CL2'ID'                                                01200408            
          DC    9C' '                                                  01200508            
          DC    CL4'NAME'                                              01200608            
          DC    28C' '                                                 01200708            
          DC    CL3'PAY'                                               01200808            
          DC    4C' '                                                  01200908            
          DC    CL6'WORKED'                                            01201008            
          DC    11C' '                                                 01201108            
          DC    CL9'GROSS PAY'                                         01201208            
          DC    9C' '                                                  01201308            
          DC    CL11'WITHHOLDING'                                      01201408            
          DC    7C' '                                                  01201508            
          DC    CL11'WITHHOLDING'                                      01201608            
          DC    11C' '                                                 01201708            
          DC    CL7'NET PAY'                                           01201808            
          DC    C' '                                                   01201908            
*********LINE 5********************************************            01202008            
INE5      DC    C' '                                                   01202108            
          DC    9C'-'                                                  01202208            
          DC    2C' '                                                  01202308            
          DC    25C'-'                                                 01202408            
          DC    3C' '                                                  01202508            
          DC    7C'-'                                                  01202608            
          DC    3C' '                                                  01202708            
          DC    7C'-'                                                  01202808            
          DC    5C' '                                                  01202908            
          DC    15C'-'                                                 01203008            
          DC    4C' '                                                  01203108            
          DC    16C'-'                                                 01203208            
          DC    4C' '                                                  01203308            

                                                                      PAGE   10            

 SOURCE STATEMENT                                                                          
          DC    14C'-'                                                 01203408            
          DC    3C' '                                                  01203508            
          DC    16C'-'                                                 01203608            
          DC    C' '                                                   01203708            
**********LINE 6*******************************************            01203814            
INE6      DC    C' '                                                   01203914            
          DC    58C' '                                                 01204014            
          DC    CL6'TOTALS'                                            01204114            
          DC    68C' '                                                 01204214            
********TOTAL EMPLOYEE*************************************            01204314            
OTAL1     DC    C'0'                                                   01204414            
          DC    6C' '                                                  01204514            
          DC    CL20'NUMBER OF EMPLOYEES:'                             01204614            
          DC    7C' '                                                  01204714            
EMPCTR    DS    CL6                                                    01204814            
          DC    93C' '                                                 01204914            
*********EMPLOYEE INFORMATION*******************************           01205008            
NFO       DC    C'0'                                                   01205108            
EMID      DS    CL9                                                    01205208            
          DC    2C' '                                                  01205308            
EMNAME    DS    CL24                                                   01205408            
          DC    4C' '                                                  01205508            
EMRATE    DS    CL7                                                    01205608            
          DC    3C' '                                                  01205708            
HOURS     DS    CL7                                                    01205808            
          DC    5C' '                                                  01205908            
GROSS     DS    CL15                                                   01206008            
          DC    5C' '                                                  01206108            
FEDWH     DS    CL15                                                   01206208            
          DC    3C' '                                                  01206308            
STWH      DS    CL15                                                   01206408            
          DC    3C' '                                                  01206508            
NETPAY    DS    CL15                                                   01206608            
******************************************************************     01206814            
                    PRINT THE TABLE                              *     01206914            
******************************************************************     01207014            
RNTSUMR   CSECT                                                        01207114            
 ==== ENTRY LINKAGE ===========                                        01207214            
          STM   14,12,12(13)                                           01207314            
          LR    12,15                                                  01207414            
          USING PRNTSUMR,12                                            01207514            
          LA    14,PRNTSAVE                                            01207614            
          ST    13,4(,14)                                              01207714            
          ST    14,8(,13)                                              01207814            
          LR    13,14                                                  01207914            
DEREFERENCE THE LIST OF PARAMETER                                      01208014            
          L     2,0(1)                                                 01208114            
          USING $SUMMARY,2                                             01208214            
****PROCESSING TOTAL GROSS PAY*********                                01208314            
          LA    1,OTGRPAY+14                                           01208414            
          MVC   OTGRPAY(18),=X'4020206B2020206B2020206B2021204B2020'   01208514            
          EDMK  OTGRPAY(18),$PTGRSS                                    01208614            
          BCTR  1,0                                                    01208714            
          MVI   1,C'$'                                                 01208814            
          LA    1,OAGPAY+14                                            01208914            
          MVC   OAGPAY(18),=X'4020206B2020206B2020206B2021204B2020'    01209014            
          EDMK  OAGPAY(18),$PAGRSS                                     01209114            

                                                                      PAGE   11            

 SOURCE STATEMENT                                                                          
          BCTR  1,0                                                    01209214            
          MVI   1,C'$'                                                 01209314            
**********FEDERAL***********************                               01209414            
          LA    1,OTFWTH+14                                            01209514            
          MVC   OTFWTH(18),=X'4020206B2020206B2020206B2021204B2020'    01209614            
          EDMK  OTFWTH(18),$PTFWTH                                     01209714            
          BCTR  1,0                                                    01209814            
          MVI   1,C'$'                                                 01209914            
          MVC   OFWAVG(18),=X'4020206B2020206B2020206B2021204B2020'    01210014            
          EDMK  OFWAVG(18),$PAFWTH                                     01210114            
          BCTR  1,0                                                    01210214            
          MVI   1,C'$'                                                 01210314            
**********STATE**************************                              01210414            
          LA    1,OTSWTH+14                                            01210514            
          MVC   OTSWTH(18),=X'4020206B2020206B2020206B2021204B2020'    01210614            
          EDMK  OTSWTH(18),$PTSWTH                                     01210714            
          BCTR  1,0                                                    01210814            
          MVI   1,C'$'                                                 01210914            
          MVC   OSWAVG(18),=X'4020206B2020206B2020206B2021204B2020'    01211014            
          EDMK  OSWAVG(18),$PASWTH                                     01211114            
          BCTR  1,0                                                    01211214            
          MVI   1,C'$'                                                 01211314            
**********NET PAY**************************                            01211414            
          LA    1,OTNET+14                                             01211514            
          MVC   OTNET(18),=X'4020206B2020206B2020206B2021204B2020'     01211614            
          EDMK  OTNET(18),$PTNP                                        01211714            
          BCTR  1,0                                                    01211814            
          MVI   1,C'$'                                                 01211914            
          LA    1,ONETAVG+14                                           01212014            
          MVC   ONETAVG(18),=X'4020206B2020206B2020206B2021204B2020'   01212114            
          EDMK  ONETAVG(18),$PANP                                      01212214            
          BCTR  1,0                                                    01212314            
          MVI   1,C'$'                                                 01212414            
          XPRNT TOTAL2,133                                             01212514            
          XPRNT TOTAL3,133                                             01212614            
          XPRNT TOTAL4,133                                             01212714            
          XPRNT TOTAL5,133                                             01212814            
 ==== EXIT LINKAGE ============                                        01212914            
          DROP  2                                                      01213014            
          L     13,4(,13)                                              01213114            
          L     14,12(,13)                                             01213214            
          LM    0,12,20(13)                                            01213314            
          BR    14                                                     01213414            
********************************************                           01213514            
RNTSAVE   DS    18F'-1'                                                01213614            
********TOTAL AND AVERAGE GROSS PAY************************            01213714            
OTAL2     DC    C'0'                                                   01213814            
          DC    10C' '                                                 01213914            
          DC    CL16'TOTAL GROSS PAY:'                                 01214014            
          DC    3C' '                                                  01214114            
TGRPAY    DS    CL18                                                   01214214            
          DC    20C' '                                                 01214314            
          DC    CL18'AVERAGE GROSS PAY:'                               01214414            
          DC    5C' '                                                  01214514            
AGPAY     DS    CL18                                                   01214614            
          DC    24C' '                                                 01214714            
*********TOTAL AND AVG FEDERAL*****************************            01214814            

                                                                      PAGE   12            

 SOURCE STATEMENT                                                                          
OTAL3     DC    C'0'                                                   01214914            
          DC    CL26'TOTAL FEDERAL WITHHOLDING:'                       01215014            
          DC    3C' '                                                  01215114            
TFWTH     DS    CL18                                                   01215214            
          DC    10C' '                                                 01215314            
          DC    CL28'AVERAGE FEDERAL WITHHOLDING:'                     01215414            
          DC    5C' '                                                  01215514            
FWAVG     DS    CL18                                                   01215614            
          DC    24C' '                                                 01215714            
********TOTAL AND AVG STATE********************************            01215814            
OTAL4     DC    C'0'                                                   01215914            
          DC    2C' '                                                  01216014            
          DC    CL24'TOTAL STATE WITHHOLDING:'                         01216114            
          DC    3C' '                                                  01216214            
TSWTH     DS    CL18                                                   01216314            
          DC    12C' '                                                 01216414            
          DC    CL26'AVERAGE STATE WITHHOLDING:'                       01216514            
          DC    5C' '                                                  01216614            
SWAVG     DS    CL18                                                   01216714            
          DC    24C' '                                                 01216814            
********TOTAL AND AVG NET**********************************            01216914            
OTAL5     DC    C'0'                                                   01217014            
          DC    12C' '                                                 01217114            
          DC    CL14'TOTAL NET PAY: '                                  01217214            
          DC    3C' '                                                  01217314            
TNET      DS    CL18                                                   01217414            
          DC    22C' '                                                 01217514            
          DC    CL16'AVERAGE NET PAY:'                                 01217614            
          DC    5C' '                                                  01217714            
NETAVG    DS    CL18                                                   01217814            
          DC    24C' '                                                 01217914            
          END   PAYROLL                                                01218004            
              =X'4020206B2020206B2020206B2021204B2020'                                     

INGS,  NO   ERRORS                                                                         

 HIGH:    3076 LEAVING:  447216 FREE BYTES. AVERAGE:       70 BYTES/STMT ***               

00 STATEMENTS/SEC ***                                                                      

PUT BEFORE EXECUTION TIME MESSAGE IS PRODUCED BY USER PROGRAM ***                          

     CHICAGO SOFTWARE COMPANY, INC                                               PAGE:    1
         EMPLOYEE PAYROLL REPORT                                                           
OURLY     HOURS            EMPLOYEE    EMPLOYEE FEDERAL    EMPLOYEE STATE          EMPLOYEE
  PAY    WORKED           GROSS PAY         WITHHOLDING       WITHHOLDING           NET PAY
-----   -------     ---------------    ----------------    --------------   ---------------

15.25     80.50           $1,722.75              $55.99           $133.51         $1,533.25

19.00     80.75           $1,547.69              $50.30           $119.95         $1,377.44

10.29     80.00           $1,045.97              $33.99            $81.06           $930.92

22.00     77.00           $2,579.16              $83.82           $199.88         $2,295.46

23.75     28.25             $710.64              $23.10            $55.07           $632.47

22.95     80.50           $1,826.23              $59.35           $141.53         $1,625.35

23.20     78.67           $2,044.58              $66.45           $158.45         $1,819.68

15.25     80.50           $1,802.75              $58.59           $139.71         $1,604.45

19.00     80.77           $1,546.85              $50.27           $119.88         $1,376.70

10.29     80.00           $1,045.97              $33.99            $81.06           $930.92

22.00     80.00           $2,645.16              $85.97           $205.00         $2,354.19

23.75     28.25             $707.64              $23.00            $54.84           $629.80

22.95     80.50           $1,826.23              $59.35           $141.53         $1,625.35

20.20     78.67           $1,798.57              $58.45           $139.39         $1,600.73

15.25     80.50           $1,702.75              $55.34           $131.96         $1,515.45

19.00     80.75           $1,547.69              $50.30           $119.95         $1,377.44

10.29     80.00           $1,046.97              $34.03            $81.14           $931.80

22.00     80.00           $2,645.16              $85.97           $205.00         $2,354.19

23.75     28.25             $707.64              $23.00            $54.84           $629.80

     CHICAGO SOFTWARE COMPANY, INC                                               PAGE:    2
         EMPLOYEE PAYROLL REPORT                                                           
OURLY     HOURS            EMPLOYEE    EMPLOYEE FEDERAL    EMPLOYEE STATE          EMPLOYEE
  PAY    WORKED           GROSS PAY         WITHHOLDING       WITHHOLDING           NET PAY
-----   -------     ---------------    ----------------    --------------   ---------------

22.95     80.50           $1,826.23              $59.35           $141.53         $1,625.35

20.20     78.67           $1,798.57              $58.45           $139.39         $1,600.73

15.25     80.50           $1,702.75              $55.34           $131.96         $1,515.45

19.00     80.75           $1,547.69              $50.30           $119.95         $1,377.44

30.29     80.00          $26,645.97             $865.99         $2,065.06        $23,714.92

22.00     80.00           $2,645.16              $85.97           $205.00         $2,354.19

23.75     28.25             $707.64              $23.00            $54.84           $629.80

22.95     80.50           $1,826.23              $59.35           $141.53         $1,625.35

20.20     78.67           $1,798.57              $58.45           $139.39         $1,600.73

33.33     80.20           $3,148.19             $102.32           $243.98         $2,801.89

19.00     80.75           $1,547.69              $50.30           $119.95         $1,377.44

10.29     80.00           $1,025.97              $33.34            $79.51           $913.12

22.00     80.00           $2,645.16              $85.97           $205.00         $2,354.19

23.75     28.25             $707.64              $23.00            $54.84           $629.80

22.95     79.50           $2,256.28              $73.33           $174.86         $2,008.09

20.20     78.67           $1,798.57              $58.45           $139.39         $1,600.73

15.25     80.50           $1,702.75              $55.34           $131.96         $1,515.45

19.00     80.75           $1,547.69              $50.30           $119.95         $1,377.44

10.29     80.00          $65,045.97           $2,113.99         $5,041.06        $57,890.92

     CHICAGO SOFTWARE COMPANY, INC                                               PAGE:    3
         EMPLOYEE PAYROLL REPORT                                                           
OURLY     HOURS            EMPLOYEE    EMPLOYEE FEDERAL    EMPLOYEE STATE          EMPLOYEE
  PAY    WORKED           GROSS PAY         WITHHOLDING       WITHHOLDING           NET PAY
-----   -------     ---------------    ----------------    --------------   ---------------

22.00     80.00           $2,645.16              $85.97           $205.00         $2,354.19

23.75     28.25             $707.64              $23.00            $54.84           $629.80

22.95     80.50           $1,826.23              $59.35           $141.53         $1,625.35

20.20     78.67           $1,798.57              $58.45           $139.39         $1,600.73

15.25     80.50           $1,702.75              $55.34           $131.96         $1,515.45

19.00     80.75           $1,547.69              $50.30           $119.95         $1,377.44

10.29     80.00           $1,045.97              $33.99            $81.06           $930.92

22.00     80.00           $2,645.16              $85.97           $205.00         $2,354.19

23.75     28.25          $20,482.64             $665.69         $1,587.40        $18,229.55

22.95     80.50           $1,826.23              $59.35           $141.53         $1,625.35

20.20     78.67           $1,798.57              $58.45           $139.39         $1,600.73

15.25     77.53           $1,140.45              $37.06            $88.38         $1,015.01

19.00     80.75           $1,547.69              $50.30           $119.95         $1,377.44

10.29     80.00           $1,045.97              $33.99            $81.06           $930.92

22.00     80.00           $2,645.16              $85.97           $205.00         $2,354.19

23.75     28.25             $707.64              $23.00            $54.84           $629.80

22.95     80.50           $1,826.23              $59.35           $141.53         $1,625.35

20.20     78.67           $1,798.57              $58.45           $139.39         $1,600.73

15.25     80.50           $1,702.75              $55.34           $131.96         $1,515.45

     CHICAGO SOFTWARE COMPANY, INC                                               PAGE:    4
         EMPLOYEE PAYROLL REPORT                                                           
OURLY     HOURS            EMPLOYEE    EMPLOYEE FEDERAL    EMPLOYEE STATE          EMPLOYEE
  PAY    WORKED           GROSS PAY         WITHHOLDING       WITHHOLDING           NET PAY
-----   -------     ---------------    ----------------    --------------   ---------------

19.00     80.75           $1,547.69              $50.30           $119.95         $1,377.44

10.29     80.00           $1,045.97              $33.99            $81.06           $930.92

22.00     80.00           $2,645.16              $85.97           $205.00         $2,354.19

23.75     28.25             $707.64              $23.00            $54.84           $629.80

22.95     80.50           $1,893.73              $61.55           $146.76         $1,685.42

20.20     78.67           $1,798.57              $58.45           $139.39         $1,600.73

15.25     80.50           $1,779.05              $57.82           $137.88         $1,583.35

19.00     80.75           $1,543.15              $50.15           $119.59         $1,373.41

10.29     80.00           $1,445.75              $46.99           $112.05         $1,286.71

22.00     80.56           $1,916.48              $62.29           $148.53         $1,705.66

23.75     28.25             $707.64              $23.00            $54.84           $629.80

22.95     80.50           $1,826.23              $59.35           $141.53         $1,625.35

20.20     78.67           $1,798.57              $58.45           $139.39         $1,600.73

15.25     80.50           $1,702.75              $55.34           $131.96         $1,515.45

19.00     80.75           $1,547.69              $50.30           $119.95         $1,377.44

10.29     80.00           $1,665.97              $54.14           $129.11         $1,482.72

22.00     80.00           $2,645.16              $85.97           $205.00         $2,354.19

23.75     28.25           $1,307.34              $42.49           $101.32         $1,163.53

22.95     80.50           $2,489.91              $80.92           $192.97         $2,216.02

     CHICAGO SOFTWARE COMPANY, INC                                               PAGE:    5
         EMPLOYEE PAYROLL REPORT                                                           
OURLY     HOURS            EMPLOYEE    EMPLOYEE FEDERAL    EMPLOYEE STATE          EMPLOYEE
  PAY    WORKED           GROSS PAY         WITHHOLDING       WITHHOLDING           NET PAY
-----   -------     ---------------    ----------------    --------------   ---------------

20.20     78.67           $1,798.57              $58.45           $139.39         $1,600.73

15.25     80.50           $1,701.29              $55.29           $131.85         $1,514.15

19.00     80.74           $1,293.00              $42.02           $100.21         $1,150.77

10.29     80.00           $1,045.97              $33.99            $81.06           $930.92

22.00     80.00          $10,645.16             $345.97           $825.00         $9,474.19

23.75     28.25           $1,071.14              $34.81            $83.01           $953.32

45.95     78.65          $26,590.92             $864.20         $2,060.80        $23,665.92

20.20     75.67           $1,737.97              $56.48           $134.69         $1,546.80

15.25     80.50           $1,702.75              $55.34           $131.96         $1,515.45

19.00     80.75           $1,547.69              $50.30           $119.95         $1,377.44

10.29     80.00           $1,045.97              $33.99            $81.06           $930.92

27.52      4.00             $995.24              $32.35            $77.13           $885.76

