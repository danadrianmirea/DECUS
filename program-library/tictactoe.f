C     TIC-TAC-TOE LEARNING PROGRAM 
C      
C      by Ivan Pribec
C      https://github.com/ivan-pi
C
C     INITIALIZE LM TO ZERO
      DIMENSION IG(9),MA(9),JG(9),IS(200)
      MA(1)=8
      MA(2)=1
      MA(3)=6
      MA(4)=3
      MA(5)=5
      MA(6)=7
      MA(7)=4
      MA(8)=9
      MA(9)=2
C     START OF GAME
    1 MOVE=-1
      DO 6 I=1,9
      JG(I)=0
    6 CONTINUE
C     START OF MOVE
    2 MOVE=MOVE+2
      TYPE 900
  900 FORMAT(/,"YOUR MOVE= ")
      ACCEPT 901,I
  901 FORMAT(I)
C     CHECK CORRECT RANGE
      GO TO (5,5,5,5,5,5,5,5,5),I
    3 TYPE 902
  902 FORMAT("  YOU GOOFED, TRY AGAIN",/)
      MOVE=MOVE-2
      GO TO 2
    5 IG(MOVE)=MA(I)
C     CHECK NOT USED BEFORE
      IF (MOVE-1) 23,24,23
   23 IT1=MOVE-1
      DO 7 J=1,IT1
      IF (IG(MOVE)-IG(J)) 7,3,7
    7 CONTINUE
      JG(I)=1
C     CHECK IF LOSS OR TIE
      IF (MOVE-5) 26,25,25
   25 IT1=MOVE-2
      IT2=MOVE-4
      DO 8 I=1,IT2,2
      IT3=I+2
      DO 8 J=IT3,IT1,2
      IT4=J+2
      DO 8 K=IT4,MOVE,2
      IF (IG(I)+IG(J)+IG(K)-15) 8,100,8
    8 CONTINUE
      IF (MOVE-9) 9,101,9
C
C
C
C
C
C     CHECK IF POSSIBLE WIN
    9 IT1=MOVE-1
      IT2=MOVE-3
      DO 10 I=2,IT2,2
      IT3=I+2
      DO 10 J=IT3,IT1,2
      DO 11 K=1,MOVE
      IF (IG(I)+IG(K)+IG(J)-15) 11,10,11
   11 CONTINUE
      K=15-IG(I)-IG(J)
      GO TO (27,27,27,27,27,27,27,27,27),K
      GO TO 10
   27 IG(MOVE+1)=K
      JG(MA(10-IG(MOVE+1)))=2
      PAUSE 5
      TYPE 905
      GO TO 1
  905 FORMAT(/,"YOU LOSE",/,/)
   10 CONTINUE
C     CHECK IF POSSIBLE LOSS
   26 IT1=MOVE-2
      DO 12 I=1,IT1,2
      IT2=I+2
      DO 12 J=IT2,MOVE,2
      DO 13 K=1,MOVE
      IF (IG(I)+IG(J)+IG(K)-15) 13,12,13
   13 CONTINUE
      K=15-IG(I)-IG(J)
      GO TO (28,28,28,28,28,28,28,28,28),K
      GO TO 12
   28 IG(MOVE+1)=K
  103 JG(MA(10-IG(MOVE+1)))=2
      PAUSE 5
      GO TO 2
   12 CONTINUE
      IF(MOVE-7) 14,101,14
   24 JG(I)=1
C     MUST MAKE EDUCATED GUESS
   14 LAST=MOVE+1
      LOOK=0
   15 DO 16 I=1,9
      DO 17 J=1,MOVE
      IF (MA(I)-IG(J)) 17,16,17
   17 CONTINUE
      IG(MOVE+1)=MA(I)
      IF (LM) 18,103,18
   18 K=0
      IF (LOOK-LM) 19,103,19
   19 K=K+1
      LOOK=LOOK+1
      IF (IS(LOOK)) 16,16,20
   20 IF (IG(K)-IS(LOOK)) 22,19,22
   21 LOOK=LOOK+1
   22 IF (IS(LOOK)) 18,18,21
   16 CONTINUE
      LAST=LAST-2
      GO TO 103
C
C
C
C
  100 PAUSE 5
      TYPE 903
  903 FORMAT(/,"YOU WIN",/,/)
C     SAVE LOST GAME
      DO 109 I=1,LAST
      IF (I+LM-200) 110,1,110
  110 IS(I+LM)=IG(I)
  109 CONTINUE
      IS(LM+LAST+1)=-1
      LM=LM+LAST+1
      GO TO 1
  101 PAUSE 5
      TYPE 904
  904 FORMAT(/,"TIE GAME",/,/)
      GO TO 1
      END
