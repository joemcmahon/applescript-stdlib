FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� Number -- manipulate numeric values and perform common math functions

Notes:

- Some handlers originally based on ESG MathLib <http://www.esglabs.com/>, which in turn are conversions of the ones in the Cephes Mathematical Library by Stephen L. Moshier <http://netlib.org/cephes/>.


TO DO: 

- `format number`'s `using` parameter should accept either 'FNSt' constant or `numeric format record` record of formatting options:
	
		{basic format:FNSt, 
		minimum decimal places:INTEGER, 
		maximum decimal places:INTEGER, 
		minimum integral places:INTEGER, 
		minimum integral padding:INTEGER, 
		rounding behavior:MRnd}
		-- what else? e.g. include thousands separator:BOOLEAN if `decimal format` is used
		
	- another option would be to define a different record structure for each format, containing only those properties appropriate to it (this might be a bit more robust, not to mention cleaner to document)

     � 	 	$   N u m b e r   - -   m a n i p u l a t e   n u m e r i c   v a l u e s   a n d   p e r f o r m   c o m m o n   m a t h   f u n c t i o n s 
 
 N o t e s : 
 
 -   S o m e   h a n d l e r s   o r i g i n a l l y   b a s e d   o n   E S G   M a t h L i b   < h t t p : / / w w w . e s g l a b s . c o m / > ,   w h i c h   i n   t u r n   a r e   c o n v e r s i o n s   o f   t h e   o n e s   i n   t h e   C e p h e s   M a t h e m a t i c a l   L i b r a r y   b y   S t e p h e n   L .   M o s h i e r   < h t t p : / / n e t l i b . o r g / c e p h e s / > . 
 
 
 T O   D O :   
 
 -   ` f o r m a t   n u m b e r ` ' s   ` u s i n g `   p a r a m e t e r   s h o u l d   a c c e p t   e i t h e r   ' F N S t '   c o n s t a n t   o r   ` n u m e r i c   f o r m a t   r e c o r d `   r e c o r d   o f   f o r m a t t i n g   o p t i o n s : 
 	 
 	 	 { b a s i c   f o r m a t : F N S t ,   
 	 	 m i n i m u m   d e c i m a l   p l a c e s : I N T E G E R ,   
 	 	 m a x i m u m   d e c i m a l   p l a c e s : I N T E G E R ,   
 	 	 m i n i m u m   i n t e g r a l   p l a c e s : I N T E G E R ,   
 	 	 m i n i m u m   i n t e g r a l   p a d d i n g : I N T E G E R ,   
 	 	 r o u n d i n g   b e h a v i o r : M R n d } 
 	 	 - -   w h a t   e l s e ?   e . g .   i n c l u d e   t h o u s a n d s   s e p a r a t o r : B O O L E A N   i f   ` d e c i m a l   f o r m a t `   i s   u s e d 
 	 	 
 	 -   a n o t h e r   o p t i o n   w o u l d   b e   t o   d e f i n e   a   d i f f e r e n t   r e c o r d   s t r u c t u r e   f o r   e a c h   f o r m a t ,   c o n t a i n i n g   o n l y   t h o s e   p r o p e r t i e s   a p p r o p r i a t e   t o   i t   ( t h i s   m i g h t   b e   a   b i t   m o r e   r o b u s t ,   n o t   t o   m e n t i o n   c l e a n e r   t o   d o c u m e n t )  
 
   
  
 l     ��������  ��  ��        l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -     !   l     �� " #��   "   support    # � $ $    s u p p o r t !  % & % l     ��������  ��  ��   &  ' ( ' l      ) * + ) j    �� ,�� 0 _support   , N     - - 4    �� .
�� 
scpt . m     / / � 0 0  T y p e S u p p o r t * "  used for parameter checking    + � 1 1 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g (  2 3 2 l     ��������  ��  ��   3  4 5 4 i   ! 6 7 6 I      �� 8���� 
0 _error   8  9 : 9 o      ���� 0 handlername handlerName :  ; < ; o      ���� 0 etext eText <  = > = o      ���� 0 enumber eNumber >  ? @ ? o      ���� 0 efrom eFrom @  A�� A o      ���� 
0 eto eTo��  ��   7 n     B C B I    �� D���� &0 throwcommanderror throwCommandError D  E F E m     G G � H H  N u m b e r F  I J I o    ���� 0 handlername handlerName J  K L K o    ���� 0 etext eText L  M N M o    	���� 0 enumber eNumber N  O P O o   	 
���� 0 efrom eFrom P  Q�� Q o   
 ���� 
0 eto eTo��  ��   C o     ���� 0 _support   5  R S R l     ��������  ��  ��   S  T U T l     ��������  ��  ��   U  V W V l     �� X Y��   X J D--------------------------------------------------------------------    Y � Z Z � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - W  [ \ [ l     �� ] ^��   ]  
 constants    ^ � _ _    c o n s t a n t s \  ` a ` l     ��������  ��  ��   a  b c b l      d e f d j   " $�� g�� 	0 __e__   g m   " # h h @�
�_� e ; 5 the mathematical constant e (natural logarithm base)    f � i i j   t h e   m a t h e m a t i c a l   c o n s t a n t   e   ( n a t u r a l   l o g a r i t h m   b a s e ) c  j k j l     ��������  ��  ��   k  l m l l      n o p n j   % '�� q�� 0 _isequaldelta _isEqualDelta q m   % & r r =q���-� o i c multiplier used by `cmp` to allow for slight differences due to floating point's limited precision    p � s s �   m u l t i p l i e r   u s e d   b y   ` c m p `   t o   a l l o w   f o r   s l i g h t   d i f f e r e n c e s   d u e   t o   f l o a t i n g   p o i n t ' s   l i m i t e d   p r e c i s i o n m  t u t l     ��������  ��  ��   u  v w v l     �� x y��   x � � pre-calculated values (0-360� in 15� increments) -- TO DO: precalculate for 1� increments? (also, would be sufficient to calculate for 0-90�)    y � z z   p r e - c a l c u l a t e d   v a l u e s   ( 0 - 3 6 0 �   i n   1 5 �   i n c r e m e n t s )   - -   T O   D O :   p r e c a l c u l a t e   f o r   1 �   i n c r e m e n t s ?   ( a l s o ,   w o u l d   b e   s u f f i c i e n t   t o   c a l c u l a t e   f o r   0 - 9 0 � ) w  { | { j   ( e�� }�� 0 _precalcsine _precalcSine } J   ( d ~ ~   �  m   ( ) � �          �  � � � m   ) * � � ?А}��(J �  � � � m   * + � � ?�       �  � � � m   + , � � ?栞fK� �  � � � m   , / � � ?�z�X=; �  � � � m   / 2 � � ?���GH�� �  � � � m   2 5 � � ?�       �  � � � m   5 8 � � ?���GH�� �  � � � m   8 ; � � ?�z�X=; �  � � � m   ; < � � ?栞fK� �  � � � m   < = � � ?�       �  � � � m   = > � � ?А}��(J �  � � � m   > ? � �          �  � � � m   ? B � � �А}��(J �  � � � m   B E � � ��       �  � � � m   E H � � �栞fK� �  � � � m   H K � � ��z�X=; �  � � � m   K N � � ����GH�� �  � � � m   N Q � � ��       �  � � � m   Q T � � ����GH�� �  � � � m   T W � � ��z�X=; �  � � � m   W Z � � �栞fK� �  � � � m   Z ] � � ��       �  ��� � m   ] ` � � �А}��(J��   |  � � � j   f ��� ��� "0 _precalctangent _precalcTangent � J   f � � �  � � � m   f g � �          �  � � � m   g j � � ?�&^�Ĵ �  � � � m   j m � � ?�y�E�@G �  � � � m   m p � � ?�       �  � � � m   p s � � ?��z�XN� �  � � � m   s v � � @�=t,'j �  � � � m   v y��
�� 
msng �  � � � m   y | � � ��=t,'j �  � � � m   |  � � ���z�XN� �  � � � m    � � � ��       �  � � � m   � � � � ��y�E�@G �  � � � m   � � � � ��&^�Ĵ �  � � � m   � � � �          �  � � � m   � � � � ?�&^�Ĵ �  � � � m   � � � � ?�y�E�@G �  � � � m   � � � � ?�       �  � � � m   � � � � ?��z�XN� �  � � � m   � � � � @�=t,'j �  �  � m   � ���
�� 
msng   m   � � ��=t,'j  m   � � ���z�XN�  m   � �		 ��       

 m   � � ��y�E�@G �� m   � � ��&^�Ĵ��   �  l     ��������  ��  ��    l     ��������  ��  ��    l     ����   J D--------------------------------------------------------------------    � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  l     ����     parse and format    � "   p a r s e   a n d   f o r m a t  l     ��������  ��  ��     i  � �!"! I      ��#���� ,0 _makenumberformatter _makeNumberFormatter# $%$ o      ���� 0 formatstyle formatStyle% &��& o      ���� 0 
localecode 
localeCode��  ��  " l    �'()' k     �** +,+ r     -.- n    /0/ I    �������� 0 init  ��  ��  0 n    121 I    �������� 	0 alloc  ��  ��  2 n    343 o    ���� &0 nsnumberformatter NSNumberFormatter4 m     ��
�� misccura. o      ���� 0 asocformatter asocFormatter, 565 Z    �789:7 =   ;<; o    ���� 0 formatstyle formatStyle< m    ��
�� FNStFNS48 l   =>?= n   @A@ I    ��B���� "0 setnumberstyle_ setNumberStyle_B C��C l   D����D n   EFE o    ���� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyleF m    ��
�� misccura��  ��  ��  ��  A o    ���� 0 asocformatter asocFormatter>   uses exponent notation   ? �GG .   u s e s   e x p o n e n t   n o t a t i o n9 HIH =   "JKJ o     ���� 0 formatstyle formatStyleK m     !��
�� FNStFNS0I LML l  % -NOPN n  % -QRQ I   & -��S���� "0 setnumberstyle_ setNumberStyle_S T��T l  & )U����U n  & )VWV o   ' )���� 40 nsnumberformatternostyle NSNumberFormatterNoStyleW m   & '��
�� misccura��  ��  ��  ��  R o   % &���� 0 asocformatter asocFormatterO "  uses plain integer notation   P �XX 8   u s e s   p l a i n   i n t e g e r   n o t a t i o nM YZY =  0 3[\[ o   0 1���� 0 formatstyle formatStyle\ m   1 2��
�� FNStFNS1Z ]^] l  6 >_`a_ n  6 >bcb I   7 >��d���� "0 setnumberstyle_ setNumberStyle_d e��e l  7 :f����f n  7 :ghg o   8 :���� >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyleh m   7 8��
�� misccura��  ��  ��  ��  c o   6 7���� 0 asocformatter asocFormatter` - ' uses thousands separators, no exponent   a �ii N   u s e s   t h o u s a n d s   s e p a r a t o r s ,   n o   e x p o n e n t^ jkj =  A Dlml o   A B�� 0 formatstyle formatStylem m   B C�~
�~ FNStFNS2k non l  G Opqrp n  G Osts I   H O�}u�|�} "0 setnumberstyle_ setNumberStyle_u v�{v l  H Kw�z�yw n  H Kxyx o   I K�x�x @0 nsnumberformattercurrencystyle NSNumberFormatterCurrencyStyley m   H I�w
�w misccura�z  �y  �{  �|  t o   G H�v�v 0 asocformatter asocFormatterq   adds currency symbol   r �zz *   a d d s   c u r r e n c y   s y m b o lo {|{ =  R U}~} o   R S�u�u 0 formatstyle formatStyle~ m   S T�t
�t FNStFNS3| � l  X `���� n  X `��� I   Y `�s��r�s "0 setnumberstyle_ setNumberStyle_� ��q� l  Y \��p�o� n  Y \��� o   Z \�n�n >0 nsnumberformatterpercentstyle NSNumberFormatterPercentStyle� m   Y Z�m
�m misccura�p  �o  �q  �r  � o   X Y�l�l 0 asocformatter asocFormatter� ( " multiplies by 100 and appends '%'   � ��� D   m u l t i p l i e s   b y   1 0 0   a n d   a p p e n d s   ' % '� ��� =  c f��� o   c d�k�k 0 formatstyle formatStyle� m   d e�j
�j FNStFNS5� ��i� l  i s���� n  i s��� I   j s�h��g�h "0 setnumberstyle_ setNumberStyle_� ��f� l  j o��e�d� n  j o��� o   k o�c�c @0 nsnumberformatterspelloutstyle NSNumberFormatterSpellOutStyle� m   j k�b
�b misccura�e  �d  �f  �g  � o   i j�a�a 0 asocformatter asocFormatter�   uses words   � ���    u s e s   w o r d s�i  : R   v ��`��
�` .ascrerr ****      � ****� m   � ��� ��� b I n v a l i d    i n    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .� �_��
�_ 
errn� m   z }�^�^�Y� �]��
�] 
erob� o   � ��\�\ 0 formatstyle formatStyle� �[��Z
�[ 
errt� m   � ��Y
�Y 
enum�Z  6 ��� n  � ���� I   � ��X��W�X 0 
setlocale_ 
setLocale_� ��V� l  � ���U�T� n  � ���� I   � ��S��R�S *0 asnslocaleparameter asNSLocaleParameter� ��� o   � ��Q�Q 0 
localecode 
localeCode� ��P� m   � ��� ���  f o r   l o c a l e�P  �R  � o   � ��O�O 0 _support  �U  �T  �V  �W  � o   � ��N�N 0 asocformatter asocFormatter� ��� l  � ��M���M  � (note that while NSFormatter provides a global +setDefaultFormatterBehavior: option to change all NSNumberFormatters to use pre-10.4 behavior, we don't bother to setFormatterBehavior: on the assumption that it's highly unlikely nowadays that a host process would do this)   � ���    ( n o t e   t h a t   w h i l e   N S F o r m a t t e r   p r o v i d e s   a   g l o b a l   + s e t D e f a u l t F o r m a t t e r B e h a v i o r :   o p t i o n   t o   c h a n g e   a l l   N S N u m b e r F o r m a t t e r s   t o   u s e   p r e - 1 0 . 4   b e h a v i o r ,   w e   d o n ' t   b o t h e r   t o   s e t F o r m a t t e r B e h a v i o r :   o n   t h e   a s s u m p t i o n   t h a t   i t ' s   h i g h l y   u n l i k e l y   n o w a d a y s   t h a t   a   h o s t   p r o c e s s   w o u l d   d o   t h i s )� ��L� L   � ��� o   � ��K�K 0 asocformatter asocFormatter�L  ( o i note: this doesn't handle `default format` option as the appropriate default may vary according to usage   ) ��� �   n o t e :   t h i s   d o e s n ' t   h a n d l e   ` d e f a u l t   f o r m a t `   o p t i o n   a s   t h e   a p p r o p r i a t e   d e f a u l t   m a y   v a r y   a c c o r d i n g   t o   u s a g e  ��� l     �J�I�H�J  �I  �H  � ��� l     �G�F�E�G  �F  �E  � ��� i  � ���� I      �D��C�D $0 _setroundingmode _setRoundingMode� ��� o      �B�B "0 numberformatter numberFormatter� ��A� o      �@�@ &0 roundingdirection roundingDirection�A  �C  � l    ����� Z     ������ =    ��� o     �?�? &0 roundingdirection roundingDirection� l   ��>�=� m    �<
�< MRndRNhE�>  �=  � n   ��� I    �;��:�; $0 setroundingmode_ setRoundingMode_� ��9� l   
��8�7� n   
��� o    
�6�6 @0 nsnumberformatterroundhalfeven NSNumberFormatterRoundHalfEven� m    �5
�5 misccura�8  �7  �9  �:  � o    �4�4 "0 numberformatter numberFormatter� ��� =   ��� o    �3�3 &0 roundingdirection roundingDirection� l   ��2�1� m    �0
�0 MRndRNhT�2  �1  � ��� n   ��� I    �/��.�/ $0 setroundingmode_ setRoundingMode_� ��-� l   ��,�+� n   ��� o    �*�* @0 nsnumberformatterroundhalfdown NSNumberFormatterRoundHalfDown� m    �)
�) misccura�,  �+  �-  �.  � o    �(�( "0 numberformatter numberFormatter� ��� =  " %��� o   " #�'�' &0 roundingdirection roundingDirection� l  # $��&�%� m   # $�$
�$ MRndRNhF�&  �%  � ��� n  ( 0��� I   ) 0�#��"�# $0 setroundingmode_ setRoundingMode_� ��!� l  ) ,�� �� n  ) ,��� o   * ,�� <0 nsnumberformatterroundhalfup NSNumberFormatterRoundHalfUp� m   ) *�
� misccura�   �  �!  �"  � o   ( )�� "0 numberformatter numberFormatter� ��� =  3 6��� o   3 4�� &0 roundingdirection roundingDirection� l  4 5���� m   4 5�
� MRndRN_T�  �  � ��� n  9 A��� I   : A���� $0 setroundingmode_ setRoundingMode_� ��� l  : = ��  n  : = o   ; =�� 80 nsnumberformatterrounddown NSNumberFormatterRoundDown m   : ;�
� misccura�  �  �  �  � o   9 :�� "0 numberformatter numberFormatter�  =  D G o   D E�� &0 roundingdirection roundingDirection l  E F�� m   E F�
� MRndRN_F�  �   	 n  J R

 I   K R��
� $0 setroundingmode_ setRoundingMode_ �	 l  K N�� n  K N o   L N�� 40 nsnumberformatterroundup NSNumberFormatterRoundUp m   K L�
� misccura�  �  �	  �
   o   J K�� "0 numberformatter numberFormatter	  =  U X o   U V�� &0 roundingdirection roundingDirection l  V W�� m   V W� 
�  MRndRN_U�  �    n  [ c I   \ c������ $0 setroundingmode_ setRoundingMode_ �� l  \ _���� n  \ _ o   ] _���� >0 nsnumberformatterroundceiling NSNumberFormatterRoundCeiling m   \ ]��
�� misccura��  ��  ��  ��   o   [ \���� "0 numberformatter numberFormatter   =  f i!"! o   f g���� &0 roundingdirection roundingDirection" l  g h#����# m   g h��
�� MRndRN_D��  ��    $��$ n  l t%&% I   m t��'���� $0 setroundingmode_ setRoundingMode_' (��( l  m p)����) n  m p*+* o   n p���� :0 nsnumberformatterroundfloor NSNumberFormatterRoundFloor+ m   m n��
�� misccura��  ��  ��  ��  & o   l m���� "0 numberformatter numberFormatter��  � n  w �,-, I   | ���.���� >0 throwinvalidparameterconstant throwInvalidParameterConstant. /0/ o   | }���� &0 roundingdirection roundingDirection0 1��1 m   } �22 �33  b y��  ��  - o   w |���� 0 _support  �   TO DO: finish   � �44    T O   D O :   f i n i s h� 565 l     ��������  ��  ��  6 787 l     ��������  ��  ��  8 9:9 i  � �;<; I      ��=����  0 _nameforformat _nameForFormat= >��> o      ���� 0 formatstyle formatStyle��  ��  < l    H?@A? Z     HBCDEB =    FGF o     ���� 0 formatstyle formatStyleG m    ��
�� FNStFNS0C L    HH m    II �JJ  i n t e g e rD KLK =   MNM o    ���� 0 formatstyle formatStyleN m    ��
�� FNStFNS1L OPO L    QQ m    RR �SS  d e c i m a lP TUT =   VWV o    ���� 0 formatstyle formatStyleW m    ��
�� FNStFNS2U XYX L    ZZ m    [[ �\\  c u r r e n c yY ]^] =  ! $_`_ o   ! "���� 0 formatstyle formatStyle` m   " #��
�� FNStFNS3^ aba L   ' )cc m   ' (dd �ee  p e r c e n tb fgf =  , /hih o   , -���� 0 formatstyle formatStylei m   - .��
�� FNStFNS4g jkj L   2 4ll m   2 3mm �nn  s c i e n t i f i ck opo =  7 :qrq o   7 8���� 0 formatstyle formatStyler m   8 9��
�� FNStFNS5p s��s L   = ?tt m   = >uu �vv  w o r d��  E L   B Hww b   B Gxyx b   B Ez{z m   B C|| �}}  { o   C D���� 0 formatstyle formatStyley m   E F~~ �  @ G A used for error reporting; formatStyle is either constant or text   A ��� �   u s e d   f o r   e r r o r   r e p o r t i n g ;   f o r m a t S t y l e   i s   e i t h e r   c o n s t a n t   o r   t e x t: ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I      �������� 60 _canonicalnumberformatter _canonicalNumberFormatter��  ��  � l    &���� k     &�� ��� r     ��� n    ��� I    �������� 0 init  ��  ��  � n    ��� I    �������� 	0 alloc  ��  ��  � n    ��� o    ���� &0 nsnumberformatter NSNumberFormatter� m     ��
�� misccura� o      ���� 0 asocformatter asocFormatter� ��� n   ��� I    ������� "0 setnumberstyle_ setNumberStyle_� ���� l   ������ n   ��� o    ���� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle� m    ��
�� misccura��  ��  ��  ��  � o    ���� 0 asocformatter asocFormatter� ��� l   #���� n   #��� I    #������� 0 
setlocale_ 
setLocale_� ���� l   ������ n   ��� I    �������� 0 systemlocale systemLocale��  ��  � n   ��� o    ���� 0 nslocale NSLocale� m    ��
�� misccura��  ��  ��  ��  � o    ���� 0 asocformatter asocFormatter� [ U note: NSNumberFormatter uses currentLocale by default, which isn't what we want here   � ��� �   n o t e :   N S N u m b e r F o r m a t t e r   u s e s   c u r r e n t L o c a l e   b y   d e f a u l t ,   w h i c h   i s n ' t   w h a t   w e   w a n t   h e r e� ���� L   $ &�� o   $ %���� 0 asocformatter asocFormatter��  � . ( TO DO: use this for complex formatting?   � ��� P   T O   D O :   u s e   t h i s   f o r   c o m p l e x   f o r m a t t i n g ?� ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  �  -----   � ��� 
 - - - - -� ��� l     ��������  ��  ��  � ��� i  � ���� I     ����
�� .Mth:FNumnull���     nmbr� o      ���� 0 	thenumber 	theNumber� ����
�� 
Usin� |����������  ��  � o      ���� 0 formatstyle formatStyle��  � l     ������ m      ��
�� FNStFNSD��  ��  � �����
�� 
Loca� |����������  ��  � o      ���� 0 
localecode 
localeCode��  � l     ������ m      ��
�� 
msng��  ��  ��  � Q     ����� k    q�� ��� l   "���� Z   "������� =    ��� l   ������ I   ����
�� .corecnte****       ****� J    �� ���� o    ���� 0 	thenumber 	theNumber��  � �����
�� 
kocl� m    ��
�� 
nmbr��  ��  ��  � m    ��  � n   ��� I    �~��}�~ 60 throwinvalidparametertype throwInvalidParameterType� ��� o    �|�| 0 	thenumber 	theNumber� ��� m    �� ���  � ��� m    �� ���  n u m b e r� ��{� m    �z
�z 
nmbr�{  �}  � o    �y�y 0 _support  ��  ��  � � � only accept integer or real types (i.e. allowing a text parameter to be coerced to number would defeat the purpose of these handlers, which is to avoid unintended localization behavior)   � ���t   o n l y   a c c e p t   i n t e g e r   o r   r e a l   t y p e s   ( i . e .   a l l o w i n g   a   t e x t   p a r a m e t e r   t o   b e   c o e r c e d   t o   n u m b e r   w o u l d   d e f e a t   t h e   p u r p o s e   o f   t h e s e   h a n d l e r s ,   w h i c h   i s   t o   a v o i d   u n i n t e n d e d   l o c a l i z a t i o n   b e h a v i o r )� ��� Z   # >���x�w� =  # &��� o   # $�v�v 0 formatstyle formatStyle� m   $ %�u
�u FNStFNSD� Z   ) :���t�� =  ) .��� n  ) ,��� m   * ,�s
�s 
pcls� o   ) *�r�r 0 	thenumber 	theNumber� m   , -�q
�q 
long� r   1 4��� m   1 2�p
�p FNStFNS0� o      �o�o 0 formatstyle formatStyle�t  � r   7 :��� m   7 8�n
�n FNStFNS4� o      �m�m 0 formatstyle formatStyle�x  �w  � � � r   ? H I   ? F�l�k�l ,0 _makenumberformatter _makeNumberFormatter  o   @ A�j�j 0 formatstyle formatStyle �i o   A B�h�h 0 
localecode 
localeCode�i  �k   o      �g�g 0 asocformatter asocFormatter   r   I Q	
	 n  I O I   J O�f�e�f &0 stringfromnumber_ stringFromNumber_ �d o   J K�c�c 0 	thenumber 	theNumber�d  �e   o   I J�b�b 0 asocformatter asocFormatter
 o      �a�a 0 
asocstring 
asocString  l  R j Z  R j�`�_ =  R U o   R S�^�^ 0 
asocstring 
asocString m   S T�]
�] 
msng R   X f�\
�\ .ascrerr ****      � **** m   b e � F I n v a l i d   n u m b e r   ( c o n v e r s i o n   f a i l e d ) . �[
�[ 
errn m   Z ]�Z�Z�Y �Y�X
�Y 
erob o   ` a�W�W 0 	thenumber 	theNumber�X  �`  �_   n h shouldn't fail, but -stringFromNumber:'s return type isn't declared as non-nullable so check to be sure    � �   s h o u l d n ' t   f a i l ,   b u t   - s t r i n g F r o m N u m b e r : ' s   r e t u r n   t y p e   i s n ' t   d e c l a r e d   a s   n o n - n u l l a b l e   s o   c h e c k   t o   b e   s u r e  �V  L   k q!! c   k p"#" o   k l�U�U 0 
asocstring 
asocString# m   l o�T
�T 
ctxt�V  � R      �S$%
�S .ascrerr ****      � ****$ o      �R�R 0 etext eText% �Q&'
�Q 
errn& o      �P�P 0 enumber eNumber' �O()
�O 
erob( o      �N�N 0 efrom eFrom) �M*�L
�M 
errt* o      �K�K 
0 eto eTo�L  � I   y ��J+�I�J 
0 _error  + ,-, m   z }.. �//  f o r m a t   n u m b e r- 010 o   } ~�H�H 0 etext eText1 232 o   ~ �G�G 0 enumber eNumber3 454 o    ��F�F 0 efrom eFrom5 6�E6 o   � ��D�D 
0 eto eTo�E  �I  � 787 l     �C�B�A�C  �B  �A  8 9:9 l     �@�?�>�@  �?  �>  : ;<; i  � �=>= I     �=?@
�= .Mth:PNumnull���     ctxt? o      �<�< 0 thetext theText@ �;AB
�; 
UsinA |�:�9C�8D�:  �9  C o      �7�7 0 formatstyle formatStyle�8  D l     E�6�5E m      �4
�4 FNStFNSD�6  �5  B �3F�2
�3 
LocaF |�1�0G�/H�1  �0  G o      �.�. 0 
localecode 
localeCode�/  H l     I�-�,I m      �+
�+ 
msng�-  �,  �2  > Q     �JKLJ k    �MM NON l   "PQRP Z   "ST�*�)S =    UVU l   W�(�'W I   �&XY
�& .corecnte****       ****X J    ZZ [�%[ o    �$�$ 0 thetext theText�%  Y �#\�"
�# 
kocl\ m    �!
�! 
ctxt�"  �(  �'  V m    � �   T n   ]^] I    �_�� 60 throwinvalidparametertype throwInvalidParameterType_ `a` o    �� 0 thetext theTexta bcb m    dd �ee  c fgf m    hh �ii  t e x tg j�j m    �
� 
ctxt�  �  ^ o    �� 0 _support  �*  �)  Q 1 + only accept text, for same reason as above   R �kk V   o n l y   a c c e p t   t e x t ,   f o r   s a m e   r e a s o n   a s   a b o v eO lml Z  # 0no��n =  # &pqp o   # $�� 0 formatstyle formatStyleq m   $ %�
� FNStFNSDo r   ) ,rsr m   ) *�
� FNStFNS4s o      �� 0 formatstyle formatStyle�  �  m tut r   1 :vwv I   1 8�x�� ,0 _makenumberformatter _makeNumberFormatterx yzy o   2 3�� 0 formatstyle formatStylez {�{ o   3 4�� 0 
localecode 
localeCode�  �  w o      �� 0 asocformatter asocFormatteru |}| r   ; C~~ n  ; A��� I   < A���� &0 numberfromstring_ numberFromString_� ��� o   < =�
�
 0 thetext theText�  �  � o   ; <�	�	 0 asocformatter asocFormatter o      �� 0 
asocnumber 
asocNumber} ��� Z   D ������ =  D G��� o   D E�� 0 
asocnumber 
asocNumber� m   E F�
� 
msng� k   J ��� ��� r   J W��� c   J U��� n  J S��� I   O S���� $0 localeidentifier localeIdentifier�  �  � n  J O��� I   K O� �����  
0 locale  ��  ��  � o   J K���� 0 asocformatter asocFormatter� m   S T��
�� 
ctxt� o      ���� $0 localeidentifier localeIdentifier� ��� Z   X q������ =   X ]��� n  X [��� 1   Y [��
�� 
leng� o   X Y���� $0 localeidentifier localeIdentifier� m   [ \����  � l  ` c���� r   ` c��� m   ` a�� ���  n o� o      ���� $0 localeidentifier localeIdentifier� #  empty string = system locale   � ��� :   e m p t y   s t r i n g   =   s y s t e m   l o c a l e��  � r   f q��� b   f o��� b   f k��� m   f i�� ��� 
 t h e   � o   i j���� $0 localeidentifier localeIdentifier� m   k n�� ���  � o      ���� $0 localeidentifier localeIdentifier� ���� R   r �����
�� .ascrerr ****      � ****� l  ~ ������� b   ~ ���� b   ~ ���� b   ~ ���� b   ~ ���� m   ~ ��� ��� R I n v a l i d   t e x t   ( e x p e c t e d   n u m e r i c a l   t e x t   i n  � I   � ��������  0 _nameforformat _nameForFormat� ���� o   � ����� 0 formatstyle formatStyle��  ��  � m   � ��� ���    f o r m a t   f o r  � o   � ����� $0 localeidentifier localeIdentifier� m   � ��� ���    l o c a l e ) .��  ��  � ����
�� 
errn� m   v y�����Y� �����
�� 
erob� o   | }���� 0 thetext theText��  ��  �  �  � ���� L   � ��� c   � ���� o   � ����� 0 
asocnumber 
asocNumber� m   � ���
�� 
****��  K R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  L I   � �������� 
0 _error  � ��� m   � ��� ���  p a r s e   n u m b e r� ��� o   � ����� 0 etext eText� ��� o   � ����� 0 enumber eNumber� ��� o   � ����� 0 efrom eFrom� ���� o   � ����� 
0 eto eTo��  ��  < ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  � $  Hexadecimal number conversion   � ��� <   H e x a d e c i m a l   n u m b e r   c o n v e r s i o n� ��� l     ��������  ��  ��  � ��� i  � ���� I     ����
�� .Mth:NuHenull���     ****� o      ���� 0 	thenumber 	theNumber� ����
�� 
Plac� |����������  ��  � o      ���� 0 	chunksize 	chunkSize��  � l     ������ m      ����  ��  ��  � �����
�� 
Pref� |����������  ��  � o      ���� 0 	hasprefix 	hasPrefix��  � l     ������ m      ��
�� boovfals��  ��  ��  � Q    ����� k   �    r     n    I    ������ (0 asintegerparameter asIntegerParameter 	 o    	���� 0 	chunksize 	chunkSize	 
��
 m   	 
 � 
 w i d t h��  ��   o    ���� 0 _support   o      ���� 0 	chunksize 	chunkSize  l    r     n    I    ������ (0 asbooleanparameter asBooleanParameter  o    ���� 0 	hasprefix 	hasPrefix �� m     �  p r e f i x��  ��   o    ���� 0 _support   o      ���� 0 	hasprefix 	hasPrefix � � (users shouldn't concatenate their own prefix as that would result in negative numbers appearing as "0x-N�" instead of "-0xN�")    �    ( u s e r s   s h o u l d n ' t   c o n c a t e n a t e   t h e i r   o w n   p r e f i x   a s   t h a t   w o u l d   r e s u l t   i n   n e g a t i v e   n u m b e r s   a p p e a r i n g   a s   " 0 x - N & "   i n s t e a d   o f   " - 0 x N & " ) �� Z   ���  =    *!"! l   (#����# I   (��$%
�� .corecnte****       ****$ J    "&& '��' o     ���� 0 	thenumber 	theNumber��  % ��(��
�� 
kocl( m   # $��
�� 
list��  ��  ��  " m   ( )����   l  -E)*+) k   -E,, -.- l  - :/01/ r   - :232 n  - 8454 I   2 8��6���� 00 aswholenumberparameter asWholeNumberParameter6 787 o   2 3���� 0 	thenumber 	theNumber8 9��9 m   3 4:: �;;  ��  ��  5 o   - 2���� 0 _support  3 o      ���� 0 	thenumber 	theNumber0 ^ X numbers greater than 2^30 (max integer size) are okay as long as they're non-fractional   1 �<< �   n u m b e r s   g r e a t e r   t h a n   2 ^ 3 0   ( m a x   i n t e g e r   s i z e )   a r e   o k a y   a s   l o n g   a s   t h e y ' r e   n o n - f r a c t i o n a l. =>= l  ; ;��?@��  ? � � note that the 1024 max chunk size is somewhat arbitrary (the largest representable number requires ~309 chars; anything more will always be left-hand padding), but prevents completely silly values   @ �AA�   n o t e   t h a t   t h e   1 0 2 4   m a x   c h u n k   s i z e   i s   s o m e w h a t   a r b i t r a r y   ( t h e   l a r g e s t   r e p r e s e n t a b l e   n u m b e r   r e q u i r e s   ~ 3 0 9   c h a r s ;   a n y t h i n g   m o r e   w i l l   a l w a y s   b e   l e f t - h a n d   p a d d i n g ) ,   b u t   p r e v e n t s   c o m p l e t e l y   s i l l y   v a l u e s> BCB Z  ; ZDE����D G   ; FFGF A   ; >HIH o   ; <���� 0 	chunksize 	chunkSizeI m   < =����  G ?   A DJKJ o   A B���� 0 	chunksize 	chunkSizeK m   B C���� E n  I VLML I   N V��N���� .0 throwinvalidparameter throwInvalidParameterN OPO o   N O���� 0 	chunksize 	chunkSizeP QRQ m   O PSS �TT 
 w i d t hR UVU m   P Q��
�� 
longV W��W m   Q RXX �YY  m u s t   b e   0  1 0 2 4��  ��  M o   I N���� 0 _support  ��  ��  C Z[Z r   [ `\]\ m   [ ^^^ �__  ] o      ���� 0 hextext hexText[ `a` Z   a �bc��db A   a defe o   a b���� 0 	thenumber 	theNumberf m   b c����  c k   g �gg hih Z  g �jk����j F   g vlml ?   g jnon o   g h���� 0 	chunksize 	chunkSizeo m   h i����  m l  m tp����p A   m tqrq o   m n���� 0 	thenumber 	theNumberr a   n ssts m   n q����t o   q r�~�~ 0 	chunksize 	chunkSize��  ��  k n  y �uvu I   ~ ��}w�|�} .0 throwinvalidparameter throwInvalidParameterw xyx o   ~ �{�{ 0 	thenumber 	theNumbery z{z m    �|| �}}  { ~~ m   � ��z
�z 
long ��y� b   � ���� b   � ���� b   � ���� m   � ��� ��� X s p e c i f i e d   w i d t h   o n l y   a l l o w s   n u m b e r s   b e t w e e n  � l  � ���x�w� a   � ���� m   � ��v�v��� o   � ��u�u 0 	chunksize 	chunkSize�x  �w  � m   � ��� ��� 
   a n d  � l  � ���t�s� \   � ���� a   � ���� m   � ��r�r � o   � ��q�q 0 	chunksize 	chunkSize� m   � ��p�p �t  �s  �y  �|  v o   y ~�o�o 0 _support  ��  ��  i ��� r   � ���� m   � ��� ���  -� o      �n�n 0 	hexprefix 	hexPrefix� ��m� r   � ���� d   � ��� o   � ��l�l 0 	thenumber 	theNumber� o      �k�k 0 	thenumber 	theNumber�m  ��  d k   � ��� ��� r   � ���� m   � ��� ���  � o      �j�j 0 	hexprefix 	hexPrefix� ��i� Z  � ����h�g� F   � ���� ?   � ���� o   � ��f�f 0 	chunksize 	chunkSize� m   � ��e�e  � l  � ���d�c� ?   � ���� o   � ��b�b 0 	thenumber 	theNumber� \   � ���� a   � ���� m   � ��a�a � o   � ��`�` 0 	chunksize 	chunkSize� m   � ��_�_ �d  �c  � n  � ���� I   � ��^��]�^ .0 throwinvalidparameter throwInvalidParameter� ��� o   � ��\�\ 0 	thenumber 	theNumber� ��� m   � ��� ���  � ��� m   � ��[
�[ 
long� ��Z� b   � ���� b   � ���� b   � ���� m   � ��� ��� X s p e c i f i e d   w i d t h   o n l y   a l l o w s   n u m b e r s   b e t w e e n  � l  � ���Y�X� a   � ���� m   � ��W�W��� o   � ��V�V 0 	chunksize 	chunkSize�Y  �X  � m   � ��� ��� 
   a n d  � l  � ���U�T� \   � ���� a   � ���� m   � ��S�S � o   � ��R�R 0 	chunksize 	chunkSize� m   � ��Q�Q �U  �T  �Z  �]  � o   � ��P�P 0 _support  �h  �g  �i  a ��� Z  � ����O�N� o   � ��M�M 0 	hasprefix 	hasPrefix� r   � ���� b   � ���� o   � ��L�L 0 	hexprefix 	hexPrefix� m   � ��� ���  0 x� o      �K�K 0 	hexprefix 	hexPrefix�O  �N  � ��� V   '��� k  "�� ��� r  ��� b  ��� l ��J�I� n  ��� 4  �H�
�H 
cobj� l ��G�F� [  ��� `  ��� o  �E�E 0 	thenumber 	theNumber� m  �D�D � m  �C�C �G  �F  � m  �� ���   0 1 2 3 4 5 6 7 8 9 A B C D E F�J  �I  � o  �B�B 0 hextext hexText� o      �A�A 0 hextext hexText� ��@� r  "��� _   ��� o  �?�? 0 	thenumber 	theNumber� m  �>�> � o      �=�= 0 	thenumber 	theNumber�@  � ?  ��� o  �<�< 0 	thenumber 	theNumber� m  �;�;  � ��� V  (@��� r  4;��� b  49��� m  47�� �    0� o  78�:�: 0 hextext hexText� o      �9�9 0 hextext hexText� A  ,3 n  ,1 1  -1�8
�8 
leng o  ,-�7�7 0 hextext hexText o  12�6�6 0 	chunksize 	chunkSize� �5 L  AE b  AD o  AB�4�4 0 	hexprefix 	hexPrefix o  BC�3�3 0 hextext hexText�5  *   format single number   + �		 *   f o r m a t   s i n g l e   n u m b e r��    l H�

 k  H�  l Hk Z Hk�2�1 G  HS A  HK o  HI�0�0 0 	chunksize 	chunkSize m  IJ�/�/  ?  NQ o  NO�.�. 0 	chunksize 	chunkSize m  OP�-�-  n Vg I  [g�,�+�, .0 throwinvalidparameter throwInvalidParameter  o  [\�*�* 0 	chunksize 	chunkSize  !  m  \_"" �## 
 w i d t h! $%$ m  _`�)
�) 
long% &�(& m  `c'' �((  m u s t   b e   1  1 0 2 4�(  �+   o  V[�'�' 0 _support  �2  �1     chunksize must be given    �)) 0   c h u n k s i z e   m u s t   b e   g i v e n *+* r  l�,-, J  lx.. /0/ m  lo11 �22  0 3�&3 \  ov454 a  ot676 m  or�%�% 7 o  rs�$�$ 0 	chunksize 	chunkSize5 m  tu�#�# �&  - J      88 9:9 o      �"�" 0 padtext padText: ;�!; o      � �  0 maxsize maxSize�!  + <=< U  ��>?> r  ��@A@ b  ��BCB o  ���� 0 padtext padTextC m  ��DD �EE  0A o      �� 0 padtext padText? o  ���� 0 	chunksize 	chunkSize= FGF h  ���H� 0 
resultlist 
resultListH j     	�I� 
0 _list_  I n    JKJ 2   �
� 
cobjK o     �� 0 	thenumber 	theNumberG LML X  ��N�ON k  �{PP QRQ Q  �6STUS k  ��VV WXW r  ��YZY c  ��[\[ n ��]^] 1  ���
� 
pcnt^ o  ���� 0 aref aRef\ m  ���
� 
longZ o      �� 0 	thenumber 	theNumberX _�_ Z ��`a��` G  ��bcb G  ��ded >  ��fgf o  ���� 0 	thenumber 	theNumberg c  ��hih n ��jkj 1  ���
� 
pcntk o  ���� 0 aref aRefi m  ���
� 
doube A  ��lml o  ���� 0 	thenumber 	theNumberm m  ����  c ?  ��non o  ���
�
 0 	thenumber 	theNumbero o  ���	�	 0 maxsize maxSizea R  ����p
� .ascrerr ****      � ****�  p �q�
� 
errnq m  �����\�  �  �  �  T R      ��r
� .ascrerr ****      � ****�  r �s� 
� 
errns d      tt m      ������   U Z  6uv��wu ?  xyx o  ���� 0 	thenumber 	theNumbery o  ���� 0 maxsize maxSizev n 	"z{z I  "��|���� .0 throwinvalidparameter throwInvalidParameter| }~} o  ���� 0 	thenumber 	theNumber~ � m  �� ���  � ��� m  ��
�� 
long� ���� b  ��� m  �� ��� h s p e c i f i e d   w i d t h   o n l y   a l l o w s   n u m b e r s   b e t w e e n   0 . 0   a n d  � l ������ \  ��� a  ��� m  ���� � o  ���� 0 	chunksize 	chunkSize� m  ���� ��  ��  ��  ��  { o  	���� 0 _support  ��  w n %6��� I  *6������� .0 throwinvalidparameter throwInvalidParameter� ��� o  *+���� 0 aref aRef� ��� m  +.�� ���  � ��� m  ./��
�� 
long� ���� m  /2�� ��� V e x p e c t e d   n o n - n e g a t i v e   n o n - f r a c t i o n a l   n u m b e r��  ��  � o  %*���� 0 _support  R ��� r  7<��� m  7:�� ���  � o      ���� 0 hextext hexText� ��� V  =d��� k  E_�� ��� r  EW��� b  EU��� l ES������ n  ES��� 4  HS���
�� 
cobj� l KR������ [  KR��� `  KP��� o  KL���� 0 	thenumber 	theNumber� m  LO���� � m  PQ���� ��  ��  � m  EH�� ���   0 1 2 3 4 5 6 7 8 9 A B C D E F��  ��  � o  ST���� 0 hextext hexText� o      ���� 0 hextext hexText� ���� r  X_��� _  X]��� o  XY���� 0 	thenumber 	theNumber� m  Y\���� � o      ���� 0 	thenumber 	theNumber��  � ?  AD��� o  AB���� 0 	thenumber 	theNumber� m  BC����  � ���� r  e{��� n eu��� 7 hu����
�� 
ctxt� d  nq�� o  op���� 0 	chunksize 	chunkSize� m  rt������� l eh������ b  eh��� o  ef���� 0 padtext padText� o  fg���� 0 hextext hexText��  ��  � n     ��� 1  vz��
�� 
pcnt� o  uv���� 0 aref aRef��  � 0 aref aRefO n ����� o  ������ 
0 _list_  � o  ������ 0 
resultlist 
resultListM ��� r  ����� n ����� 1  ����
�� 
txdl� 1  ����
�� 
ascr� o      ���� 0 oldtids oldTIDs� ��� r  ����� m  ���� ���  � n     ��� 1  ����
�� 
txdl� 1  ����
�� 
ascr� ��� Z  �������� o  ������ 0 	hasprefix 	hasPrefix� r  ����� b  ����� m  ���� ���  0 x� n ����� o  ������ 
0 _list_  � o  ������ 0 
resultlist 
resultList� o      ���� 0 hextext hexText��  � r  ����� c  ����� n ����� o  ������ 
0 _list_  � o  ������ 0 
resultlist 
resultList� m  ����
�� 
ctxt� o      ���� 0 hextext hexText� ��� r  ����� o  ������ 0 oldtids oldTIDs� n     ��� 1  ����
�� 
txdl� 1  ����
�� 
ascr� ���� L  ���� o  ������ 0 hextext hexText��     format list of number    ��� ,   f o r m a t   l i s t   o f   n u m b e r��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I  ���� ���� 
0 _error     m  �� � $ f o r m a t   h e x a d e c i m a l  o  ������ 0 etext eText  o  ������ 0 enumber eNumber 	
	 o  ������ 0 efrom eFrom
 �� o  ������ 
0 eto eTo��  ��  �  l     ��������  ��  ��    l     ��������  ��  ��    i  � � I     ��
�� .Mth:HeNunull���     ctxt o      ���� 0 hextext hexText ��
�� 
Plac |��������  ��   o      ���� 0 	chunksize 	chunkSize��   l     ���� m      ����  ��  ��   ����
�� 
Prec |��������  ��   o      ���� 0 	isprecise 	isPrecise��   l     ���� m      ��
�� boovtrue��  ��  ��   Q    b ! P   L"#$" k   K%% &'& r    ()( n   *+* I    ��,���� "0 astextparameter asTextParameter, -.- o    ���� 0 hextext hexText. /��/ m    00 �11  ��  ��  + o    ���� 0 _support  ) o      ���� 0 hextext hexText' 232 r    #454 n   !676 I    !��8���� (0 asintegerparameter asIntegerParameter8 9:9 o    ���� 0 	chunksize 	chunkSize: ;��; m    << �== 
 w i d t h��  ��  7 o    ���� 0 _support  5 o      ���� 0 	chunksize 	chunkSize3 >?> Z  $ C@A����@ G   $ /BCB A   $ 'DED o   $ %���� 0 	chunksize 	chunkSizeE m   % &����  C ?   * -FGF o   * +���� 0 	chunksize 	chunkSizeG m   + ,���� A n  2 ?HIH I   7 ?�J�~� .0 throwinvalidparameter throwInvalidParameterJ KLK o   7 8�}�} 0 	chunksize 	chunkSizeL MNM m   8 9OO �PP 
 w i d t hN QRQ m   9 :�|
�| 
longR S�{S m   : ;TT �UU  m u s t   b e   0  1 0 2 4�{  �~  I o   2 7�z�z 0 _support  ��  ��  ? VWV r   D RXYX H   D PZZ n  D O[\[ I   I O�y]�x�y (0 asbooleanparameter asBooleanParameter] ^_^ o   I J�w�w 0 	isprecise 	isPrecise_ `�v` m   J Kaa �bb  p r e c i s i o n   l o s s�v  �x  \ o   D I�u�u 0 _support  Y o      �t�t 0 	isprecise 	isPreciseW c�sc Z   SKde�rfd =   S Vghg o   S T�q�q 0 	chunksize 	chunkSizeh m   T U�p�p  e l  Y;ijki k   Y;ll mnm Q   Yopqo k   \ �rr sts r   \ _uvu m   \ ]�o�o  v o      �n�n 0 	thenumber 	theNumbert wxw r   ` eyzy C   ` c{|{ o   ` a�m�m 0 hextext hexText| m   a b}} �~~  -z o      �l�l 0 
isnegative 
isNegativex � Z  f }���k�j� o   f g�i�i 0 
isnegative 
isNegative� r   j y��� n   j w��� 7  k w�h��
�h 
ctxt� m   q s�g�g � m   t v�f�f��� o   j k�e�e 0 hextext hexText� o      �d�d 0 hextext hexText�k  �j  � ��� Z  ~ ����c�b� C   ~ ���� o   ~ �a�a 0 hextext hexText� m    ��� ���  0 x� r   � ���� n   � ���� 7  � ��`��
�` 
ctxt� m   � ��_�_ � m   � ��^�^��� o   � ��]�] 0 hextext hexText� o      �\�\ 0 hextext hexText�c  �b  � ��[� X   � ���Z�� k   � ��� ��� r   � ���� ]   � ���� o   � ��Y�Y 0 	thenumber 	theNumber� m   � ��X�X � o      �W�W 0 	thenumber 	theNumber� ��� r   � ���� I  � ���V�� z�U�T
�U .sysooffslong    ��� null
�T misccura�V  � �S��
�S 
psof� o   � ��R�R 0 charref charRef� �Q��P
�Q 
psin� m   � ��� ���   0 1 2 3 4 5 6 7 8 9 A B C D E F�P  � o      �O�O 0 i  � ��� Z  � ����N�M� =   � ���� o   � ��L�L 0 i  � m   � ��K�K  � R   � ��J�I�
�J .ascrerr ****      � ****�I  � �H��G
�H 
errn� m   � ��F�F�@�G  �N  �M  � ��E� r   � ���� \   � ���� [   � ���� o   � ��D�D 0 	thenumber 	theNumber� o   � ��C�C 0 i  � m   � ��B�B � o      �A�A 0 	thenumber 	theNumber�E  �Z 0 charref charRef� o   � ��@�@ 0 hextext hexText�[  p R      �?�>�
�? .ascrerr ****      � ****�>  � �=��<
�= 
errn� d      �� m      �;�;��<  q l  ����� R   ��:��
�: .ascrerr ****      � ****� m  �� ��� > N o t   a   v a l i d   h e x a d e c i m a l   n u m b e r .� �9��
�9 
errn� m   � ��8�8�Y� �7��6
�7 
erob� o  �5�5 0 hextext hexText�6  � E ? catch errors if hexText is too short or contains non-hex chars   � ��� ~   c a t c h   e r r o r s   i f   h e x T e x t   i s   t o o   s h o r t   o r   c o n t a i n s   n o n - h e x   c h a r sn ��� Z 	+���4�3� F  	��� o  	
�2�2 0 	isprecise 	isPrecise� l ��1�0� =  ��� o  �/�/ 0 	thenumber 	theNumber� [  ��� o  �.�. 0 	thenumber 	theNumber� m  �-�- �1  �0  � R  '�,��
�, .ascrerr ****      � ****� m  #&�� ��� � H e x a d e c i m a l   t e x t   i s   t o o   l a r g e   t o   c o n v e r t   t o   n u m b e r   w i t h o u t   l o s i n g   p r e c i s i o n .� �+��
�+ 
errn� m  �*�*�Y� �)��(
�) 
erob� o  !"�'�' 0 hextext hexText�(  �4  �3  � ��� Z ,8���&�%� o  ,-�$�$ 0 
isnegative 
isNegative� r  04��� d  02�� o  01�#�# 0 	thenumber 	theNumber� o      �"�" 0 	thenumber 	theNumber�&  �%  � ��!� L  9;�� o  9:� �  0 	thenumber 	theNumber�!  j   read as single number   k ��� ,   r e a d   a s   s i n g l e   n u m b e r�r  f l >K���� k  >K�� ��� Z >d����� >  >G��� `  >E��� l >C���� n >C��� 1  ?C�
� 
leng� o  >?�� 0 hextext hexText�  �  � o  CD�� 0 	chunksize 	chunkSize� m  EF��  � R  J`���
� .ascrerr ****      � ****� b  V_��� b  V[��� m  VY�� ��� T C a n ' t   s p l i t   h e x a d e c i m a l   t e x t   e x a c t l y   i n t o  � o  YZ�� 0 	chunksize 	chunkSize� m  [^�� ���  - d i g i t   c h u n k s .� ���
� 
errn� m  NQ���Y� � �
� 
erob  o  TU�� 0 hextext hexText�  �  �  �  h  ep�� 0 
resultlist 
resultList j     �� 
0 _list_   J     ��    Y  qC�	
 k  �>  r  �� m  ����   o      �� 0 	thenumber 	theNumber  X  ��
 k  ��  r  �� ]  �� o  ���	�	 0 	thenumber 	theNumber m  ����  o      �� 0 	thenumber 	theNumber  r  �� I ���  z��
� .sysooffslong    ��� null
� misccura�    �!"
� 
psof! o  ���� 0 charref charRef" �#� 
� 
psin# m  ��$$ �%%   0 1 2 3 4 5 6 7 8 9 A B C D E F�    o      ���� 0 i   &'& Z ��()����( =  ��*+* o  ������ 0 i  + m  ������  ) R  ����,-
�� .ascrerr ****      � ****, m  ��.. �// > N o t   a   v a l i d   h e x a d e c i m a l   n u m b e r .- ��01
�� 
errn0 m  �������Y1 ��2��
�� 
erob2 l ��3����3 N  ��44 n  ��565 7 ����78
�� 
ctxt7 o  ������ 0 i  8 l ��9����9 \  ��:;: [  ��<=< o  ������ 0 i  = o  ������ 0 	chunksize 	chunkSize; m  ������ ��  ��  6 o  ������ 0 hextext hexText��  ��  ��  ��  ��  ' >��> r  ��?@? \  ��ABA [  ��CDC o  ������ 0 	thenumber 	theNumberD o  ������ 0 i  B m  ������ @ o      ���� 0 	thenumber 	theNumber��  �
 0 charref charRef n ��EFE 7 ����GH
�� 
ctxtG o  ������ 0 i  H l ��I����I \  ��JKJ [  ��LML o  ������ 0 i  M o  ������ 0 	chunksize 	chunkSizeK m  ������ ��  ��  F o  ������ 0 hextext hexText NON Z 5PQ����P F  RSR o  ���� 0 	isprecise 	isPreciseS l T����T =  UVU o  ���� 0 	thenumber 	theNumberV [  
WXW o  ���� 0 	thenumber 	theNumberX m  	���� ��  ��  Q R  1��YZ
�� .ascrerr ****      � ****Y m  -0[[ �\\ � H e x a d e c i m a l   t e x t   i s   t o o   l a r g e   t o   c o n v e r t   t o   n u m b e r   w i t h o u t   l o s i n g   p r e c i s i o n .Z ��]^
�� 
errn] m  �����Y^ ��_��
�� 
erob_ l ,`����` N  ,aa n  +bcb 7 +��de
�� 
ctxtd o  !#���� 0 i  e l $*f����f \  $*ghg [  %(iji o  %&���� 0 i  j o  &'���� 0 	chunksize 	chunkSizeh m  ()���� ��  ��  c o  ���� 0 hextext hexText��  ��  ��  ��  ��  O k��k r  6>lml o  67���� 0 	thenumber 	theNumberm n      non  ;  <=o n 7<pqp o  8<���� 
0 _list_  q o  78���� 0 
resultlist 
resultList��  � 0 i   m  tu���� 	 n u{rsr 1  vz��
�� 
lengs o  uv���� 0 hextext hexText
 o  {|���� 0 	chunksize 	chunkSize t��t L  DKuu n DJvwv o  EI���� 
0 _list_  w o  DE���� 0 
resultlist 
resultList��  �   read as list of numbers   � �xx 0   r e a d   a s   l i s t   o f   n u m b e r s�s  # ��y
�� consdiacy ��z
�� conshyphz ��{
�� conspunc{ ����
�� conswhit��  $ ��|
�� conscase| ����
�� consnume��    R      ��}~
�� .ascrerr ****      � ****} o      ���� 0 etext eText~ ���
�� 
errn o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  ! I  Tb������� 
0 _error  � ��� m  UX�� ��� " p a r s e   h e x a d e c i m a l� ��� o  XY���� 0 etext eText� ��� o  YZ���� 0 enumber eNumber� ��� o  Z[���� 0 efrom eFrom� ���� o  [\���� 
0 eto eTo��  ��   ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  � !  General numeric operations   � ��� 6   G e n e r a l   n u m e r i c   o p e r a t i o n s� ��� l     ��������  ��  ��  � ��� i  � ���� I     �����
�� .Mth:DeRanull���     doub� o      ���� 0 n  ��  � Q     ���� L    �� ]    
��� l   ������ c    ��� o    ���� 0 n  � m    ��
�� 
doub��  ��  � l   	������ ^    	��� 1    ��
�� 
pi  � m    ���� ���  ��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I    ������� 
0 _error  � ��� m    �� ���  d e g 2 r a d� ��� o    ���� 0 etext eText� ��� o    ���� 0 enumber eNumber� ��� o    ���� 0 efrom eFrom� ���� o    �� 
0 eto eTo��  ��  � ��� l     �~�}�|�~  �}  �|  � ��� l     �{�z�y�{  �z  �y  � ��� i  � ���� I     �x��w
�x .Mth:RaDenull���     doub� o      �v�v 0 n  �w  � Q     ���� L    	�� ^    ��� o    �u�u 0 n  � l   ��t�s� ^    ��� 1    �r
�r 
pi  � m    �q�q ��t  �s  � R      �p��
�p .ascrerr ****      � ****� o      �o�o 0 etext eText� �n��
�n 
errn� o      �m�m 0 enumber eNumber� �l��
�l 
erob� o      �k�k 0 efrom eFrom� �j��i
�j 
errt� o      �h�h 
0 eto eTo�i  � I    �g��f�g 
0 _error  � ��� m    �� ���  r a d 2 d e g� ��� o    �e�e 0 etext eText� ��� o    �d�d 0 enumber eNumber� ��� o    �c�c 0 efrom eFrom� ��b� o    �a�a 
0 eto eTo�b  �f  � ��� l     �`�_�^�`  �_  �^  � ��� l     �]�\�[�]  �\  �[  � ��� l     �Z�Y�X�Z  �Y  �X  � ��� i  � ���� I     �W��V
�W .Mth:Abs_null���     nmbr� o      �U�U 0 n  �V  � Q     )���� k    �� ��� r    ��� c    ��� o    �T�T 0 n  � m    �S
�S 
nmbr� o      �R�R 0 n  � ��Q� Z   	 � �P� A   	  o   	 
�O�O 0 n   m   
 �N�N    L     d     o    �M�M 0 n  �P   L     o    �L�L 0 n  �Q  � R      �K
�K .ascrerr ****      � **** o      �J�J 0 etext eText �I	

�I 
errn	 o      �H�H 0 enumber eNumber
 �G
�G 
erob o      �F�F 0 efrom eFrom �E�D
�E 
errt o      �C�C 
0 eto eTo�D  � I    )�B�A�B 
0 _error    m     ! �  a b s  o   ! "�@�@ 0 etext eText  o   " #�?�? 0 enumber eNumber  o   # $�>�> 0 efrom eFrom �= o   $ %�<�< 
0 eto eTo�=  �A  �  l     �;�:�9�;  �:  �9    l     �8�7�6�8  �7  �6    i  � � !  I     �5"�4
�5 .Mth:CmpNnull���     ****" J      ## $%$ o      �3�3 0 n1  % &�2& o      �1�1 0 n2  �2  �4  ! Q     �'()' k    �** +,+ Z    �-.�0/- =    010 l   2�/�.2 I   �-34
�- .corecnte****       ****3 J    55 676 o    �,�, 0 n1  7 8�+8 o    �*�* 0 n2  �+  4 �)9�(
�) 
kocl9 m    	�'
�' 
long�(  �/  �.  1 m    �&�& . Z   :;�%�$: =    <=< o    �#�# 0 n1  = o    �"�" 0 n2  ; L    >> m    �!�!  �%  �$  �0  / k   ! �?? @A@ r   ! 8BCB J   ! )DD EFE c   ! $GHG o   ! "� �  0 n1  H m   " #�
� 
doubF I�I c   $ 'JKJ o   $ %�� 0 n2  K m   % &�
� 
doub�  C J      LL MNM o      �� 0 n1  N O�O o      �� 0 n2  �  A PQP Z   9 TRS�TR =   9 <UVU o   9 :�� 0 n1  V m   : ;��  S r   ? HWXW ]   ? FYZY o   ? D�� 0 _isequaldelta _isEqualDeltaZ o   D E�� 0 n2  X o      �� 0 dn  �  T r   K T[\[ ]   K R]^] o   K P�� 0 _isequaldelta _isEqualDelta^ o   P Q�� 0 n1  \ o      �� 0 dn  Q _`_ r   U Yaba d   U Wcc o   U V�� 0 dn  b o      �� 0 dm  ` ded Z  Z wfg��f ?   Z ]hih o   Z [�� 0 dm  i o   [ \�
�
 0 dn  g r   ` sjkj J   ` dll mnm o   ` a�	�	 0 dm  n o�o o   a b�� 0 dn  �  k J      pp qrq o      �� 0 dn  r s�s o      �� 0 dm  �  �  �  e tut r   x }vwv \   x {xyx o   x y�� 0 n2  y o   y z�� 0 n1  w o      �� 0 d  u z� z Z  ~ �{|����{ F   ~ �}~} ?   ~ �� o   ~ ���� 0 d  � o    ����� 0 dm  ~ A   � ���� o   � ����� 0 d  � o   � ����� 0 dn  | L   � ��� m   � �����  ��  ��  �   , ���� Z   � ������� A   � ���� o   � ����� 0 n1  � o   � ����� 0 n2  � L   � ��� m   � ���������  � L   � ��� m   � ����� ��  ( R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  ) I   � �������� 
0 _error  � ��� m   � ��� ���  c m p� ��� o   � ����� 0 etext eText� ��� o   � ����� 0 enumber eNumber� ��� o   � ����� 0 efrom eFrom� ���� o   � ����� 
0 eto eTo��  ��   ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I     �����
�� .Mth:MinNnull���     ****� o      ���� 0 thelist theList��  � Q     Y���� k    G�� ��� r    ��� n   ��� I    ������� "0 aslistparameter asListParameter� ��� o    	���� 0 thelist theList� ���� m   	 
�� ���  ��  ��  � o    ���� 0 _support  � o      ���� 0 thelist theList� ��� r    ��� c    ��� l   ������ n    ��� 4   ���
�� 
cobj� m    ���� � o    ���� 0 thelist theList��  ��  � m    ��
�� 
nmbr� o      ���� 0 	theresult 	theResult� ��� X    D����� k   * ?�� ��� r   * 1��� c   * /��� n  * -��� 1   + -��
�� 
pcnt� o   * +���� 0 aref aRef� m   - .��
�� 
nmbr� o      ���� 0 n  � ���� Z  2 ?������� A   2 5��� o   2 3���� 0 n  � o   3 4���� 0 	theresult 	theResult� r   8 ;��� o   8 9���� 0 n  � o      ���� 0 	theresult 	theResult��  ��  ��  �� 0 aref aRef� o    ���� 0 thelist theList� ���� L   E G�� o   E F���� 0 	theresult 	theResult��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I   O Y������� 
0 _error  � ��� m   P Q�� ���  m i n� ��� o   Q R���� 0 etext eText� ��� o   R S���� 0 enumber eNumber� ��� o   S T���� 0 efrom eFrom� ���� o   T U���� 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I     �����
�� .Mth:MaxNnull���     ****� o      ���� 0 thelist theList��  � Q     Y���� k    G�� ��� r    ��� n   ��� I    ������� "0 aslistparameter asListParameter� �	 � o    	���� 0 thelist theList	  	��	 m   	 
		 �		  ��  ��  � o    ���� 0 _support  � o      ���� 0 thelist theList� 			 r    			 c    				 l   	
����	
 n    			 4   ��	
�� 
cobj	 m    ���� 	 o    ���� 0 thelist theList��  ��  		 m    ��
�� 
nmbr	 o      ���� 0 	theresult 	theResult	 			 X    D	��		 k   * ?		 			 r   * 1			 c   * /			 n  * -			 1   + -��
�� 
pcnt	 o   * +���� 0 aref aRef	 m   - .��
�� 
nmbr	 o      ���� 0 n  	 	��	 Z  2 ?		����	 ?   2 5			 o   2 3���� 0 n  	 o   3 4���� 0 	theresult 	theResult	 r   8 ;	 	!	  o   8 9���� 0 n  	! o      ���� 0 	theresult 	theResult��  ��  ��  �� 0 aref aRef	 o    ���� 0 thelist theList	 	"��	" L   E G	#	# o   E F���� 0 	theresult 	theResult��  � R      ��	$	%
�� .ascrerr ****      � ****	$ o      ���� 0 etext eText	% ��	&	'
�� 
errn	& o      ���� 0 enumber eNumber	' ��	(	)
�� 
erob	( o      ���� 0 efrom eFrom	) ��	*��
�� 
errt	* o      ���� 
0 eto eTo��  � I   O Y�	+�~� 
0 _error  	+ 	,	-	, m   P Q	.	. �	/	/  m a x	- 	0	1	0 o   Q R�}�} 0 etext eText	1 	2	3	2 o   R S�|�| 0 enumber eNumber	3 	4	5	4 o   S T�{�{ 0 efrom eFrom	5 	6�z	6 o   T U�y�y 
0 eto eTo�z  �~  � 	7	8	7 l     �x�w�v�x  �w  �v  	8 	9	:	9 l     �u�t�s�u  �t  �s  	: 	;	<	; i  � �	=	>	= I     �r	?	@
�r .Mth:RouNnull���     doub	? o      �q�q 0 num  	@ �p	A	B
�p 
Plac	A |�o�n	C�m	D�o  �n  	C o      �l�l 0 decimalplaces decimalPlaces�m  	D l     	E�k�j	E m      �i�i  �k  �j  	B �h	F�g
�h 
Dire	F |�f�e	G�d	H�f  �e  	G o      �c�c &0 roundingdirection roundingDirection�d  	H l     	I�b�a	I m      �`
�` MRndRNhE�b  �a  �g  	> Q    �	J	K	L	J k   �	M	M 	N	O	N r    	P	Q	P n   	R	S	R I    �_	T�^�_ "0 asrealparameter asRealParameter	T 	U	V	U o    	�]�] 0 num  	V 	W�\	W m   	 
	X	X �	Y	Y  �\  �^  	S o    �[�[ 0 _support  	Q o      �Z�Z 0 num  	O 	Z	[	Z r    	\	]	\ n   	^	_	^ I    �Y	`�X�Y (0 asintegerparameter asIntegerParameter	` 	a	b	a o    �W�W 0 decimalplaces decimalPlaces	b 	c�V	c m    	d	d �	e	e  t o   p l a c e s�V  �X  	_ o    �U�U 0 _support  	] o      �T�T 0 decimalplaces decimalPlaces	[ 	f	g	f Z    8	h	i�S�R	h >    "	j	k	j o     �Q�Q 0 decimalplaces decimalPlaces	k m     !�P�P  	i k   % 4	l	l 	m	n	m r   % *	o	p	o a   % (	q	r	q m   % &�O�O 
	r o   & '�N�N 0 decimalplaces decimalPlaces	p o      �M�M 0 themultiplier theMultiplier	n 	s�L	s l  + 4	t	u	v	t r   + 4	w	x	w ^   + 2	y	z	y ]   + 0	{	|	{ ]   + .	}	~	} o   + ,�K�K 0 num  	~ m   , -�J�J 
	| o   . /�I�I 0 themultiplier theMultiplier	z m   0 1�H�H 
	x o      �G�G 0 num  	u�� multiplying and dividing by 10 before and after applying the multiplier helps avoid poor rounding results for some numbers due to inevitable loss of precision in floating-point math (e.g. `324.21 * 100 div 1 / 100` returns 324.2 but needs to be 324.21), though this hasn't been tested on all possible values for obvious reasons -- TO DO: shouldn't /10 be done after rounding is applied (in which case following calculations should use mod 10, etc)?   	v �		�   m u l t i p l y i n g   a n d   d i v i d i n g   b y   1 0   b e f o r e   a n d   a f t e r   a p p l y i n g   t h e   m u l t i p l i e r   h e l p s   a v o i d   p o o r   r o u n d i n g   r e s u l t s   f o r   s o m e   n u m b e r s   d u e   t o   i n e v i t a b l e   l o s s   o f   p r e c i s i o n   i n   f l o a t i n g - p o i n t   m a t h   ( e . g .   ` 3 2 4 . 2 1   *   1 0 0   d i v   1   /   1 0 0 `   r e t u r n s   3 2 4 . 2   b u t   n e e d s   t o   b e   3 2 4 . 2 1 ) ,   t h o u g h   t h i s   h a s n ' t   b e e n   t e s t e d   o n   a l l   p o s s i b l e   v a l u e s   f o r   o b v i o u s   r e a s o n s   - -   T O   D O :   s h o u l d n ' t   / 1 0   b e   d o n e   a f t e r   r o u n d i n g   i s   a p p l i e d   ( i n   w h i c h   c a s e   f o l l o w i n g   c a l c u l a t i o n s   s h o u l d   u s e   m o d   1 0 ,   e t c ) ?�L  �S  �R  	g 	�	�	� Z   9y	�	�	�	�	� =  9 <	�	�	� o   9 :�F�F &0 roundingdirection roundingDirection	� l  : ;	��E�D	� m   : ;�C
�C MRndRNhE�E  �D  	� Z   ? m	�	�	�	�	� E  ? K	�	�	� J   ? C	�	� 	�	�	� m   ? @	�	� ��      	� 	��B	� m   @ A	�	� ?�      �B  	� J   C J	�	� 	��A	� `   C H	�	�	� l  C F	��@�?	� ^   C F	�	�	� o   C D�>�> 0 num  	� m   D E�=�= �@  �?  	� m   F G�<�< �A  	� l  N S	�	�	�	� r   N S	�	�	� _   N Q	�	�	� o   N O�;�; 0 num  	� m   O P�:�: 	� o      �9�9 0 num  	� T N if num ends in .5 and its div is even then round toward zero so it stays even   	� �	�	� �   i f   n u m   e n d s   i n   . 5   a n d   i t s   d i v   i s   e v e n   t h e n   r o u n d   t o w a r d   z e r o   s o   i t   s t a y s   e v e n	� 	�	�	� ?   V Y	�	�	� o   V W�8�8 0 num  	� m   W X�7�7  	� 	��6	� l  \ c	�	�	�	� r   \ c	�	�	� _   \ a	�	�	� l  \ _	��5�4	� [   \ _	�	�	� o   \ ]�3�3 0 num  	� m   ] ^	�	� ?�      �5  �4  	� m   _ `�2�2 	� o      �1�1 0 num  	� H B else round to nearest whole digit (.5 will round up if positive�)   	� �	�	� �   e l s e   r o u n d   t o   n e a r e s t   w h o l e   d i g i t   ( . 5   w i l l   r o u n d   u p   i f   p o s i t i v e & )�6  	� l  f m	�	�	�	� r   f m	�	�	� _   f k	�	�	� l  f i	��0�/	� \   f i	�	�	� o   f g�.�. 0 num  	� m   g h	�	� ?�      �0  �/  	� m   i j�-�- 	� o      �,�, 0 num  	� 4 . (�or down if negative to give an even result)   	� �	�	� \   ( & o r   d o w n   i f   n e g a t i v e   t o   g i v e   a n   e v e n   r e s u l t )	� 	�	�	� =  p s	�	�	� o   p q�+�+ &0 roundingdirection roundingDirection	� l  q r	��*�)	� m   q r�(
�( MRndRNhT�*  �)  	� 	�	�	� Z   v �	�	�	�	�	� E  v �	�	�	� J   v z	�	� 	�	�	� m   v w	�	� ��      	� 	��'	� m   w x	�	� ?�      �'  	� J   z 	�	� 	��&	� `   z }	�	�	� o   z {�%�% 0 num  	� m   { |�$�$ �&  	� l  � �	�	�	�	� r   � �	�	�	� _   � �	�	�	� o   � ��#�# 0 num  	� m   � ��"�" 	� o      �!�! 0 num  	� 0 * if num ends in .5 then round towards zero   	� �	�	� T   i f   n u m   e n d s   i n   . 5   t h e n   r o u n d   t o w a r d s   z e r o	� 	�	�	� ?   � �	�	�	� o   � �� �  0 num  	� m   � ���  	� 	��	� l  � �	�	�	�	� r   � �	�	�	� _   � �	�	�	� l  � �	���	� [   � �	�	�	� o   � ��� 0 num  	� m   � �	�	� ?�      �  �  	� m   � ��� 	� o      �� 0 num  	� ( " else round to nearest whole digit   	� �	�	� D   e l s e   r o u n d   t o   n e a r e s t   w h o l e   d i g i t�  	� r   � �	�	�	� _   � �	�	�	� l  � �	���	� \   � �	�	�	� o   � ��� 0 num  	� m   � �	�	� ?�      �  �  	� m   � ��� 	� o      �� 0 num  	� 	�	�	� =  � �	�	�	� o   � ��� &0 roundingdirection roundingDirection	� l  � �	���	� m   � ��
� MRndRNhF�  �  	� 	�	�	� Z   � �
 



  E  � �


 J   � �

 


 m   � �
	
	 ��      
 

�

 m   � �

 ?�      �  
 J   � �

 
�
 `   � �


 o   � ��� 0 num  
 m   � ��� �  
 l  � �



 Z   � �

�

 ?   � �


 o   � ��
�
 0 num  
 m   � ��	�	  
 r   � �


 [   � �


 _   � �


 o   � ��� 0 num  
 m   � ��� 
 m   � ��� 
 o      �� 0 num  �  
 r   � �


 \   � �
 
!
  _   � �
"
#
" o   � ��� 0 num  
# m   � ��� 
! m   � ��� 
 o      �� 0 num  
 0 * if num ends in .5 then round towards zero   
 �
$
$ T   i f   n u m   e n d s   i n   . 5   t h e n   r o u n d   t o w a r d s   z e r o
 
%
&
% ?   � �
'
(
' o   � �� �  0 num  
( m   � �����  
& 
)��
) l  � �
*
+
,
* r   � �
-
.
- _   � �
/
0
/ l  � �
1����
1 [   � �
2
3
2 o   � ����� 0 num  
3 m   � �
4
4 ?�      ��  ��  
0 m   � ����� 
. o      ���� 0 num  
+ ( " else round to nearest whole digit   
, �
5
5 D   e l s e   r o u n d   t o   n e a r e s t   w h o l e   d i g i t��  
 r   � �
6
7
6 _   � �
8
9
8 l  � �
:����
: \   � �
;
<
; o   � ����� 0 num  
< m   � �
=
= ?�      ��  ��  
9 m   � ����� 
7 o      ���� 0 num  	� 
>
?
> =  � �
@
A
@ o   � ����� &0 roundingdirection roundingDirection
A l  � �
B����
B m   � ���
�� MRndRN_T��  ��  
? 
C
D
C r   � �
E
F
E _   � �
G
H
G o   � ����� 0 num  
H m   � ����� 
F o      ���� 0 num  
D 
I
J
I =  � �
K
L
K o   � ����� &0 roundingdirection roundingDirection
L l  � �
M����
M m   � ���
�� MRndRN_F��  ��  
J 
N
O
N Z   
P
Q��
R
P ?   
S
T
S o   ���� 0 num  
T m  ����  
Q r  
U
V
U [  
W
X
W _  	
Y
Z
Y o  ���� 0 num  
Z m  ���� 
X m  	
���� 
V o      ���� 0 num  ��  
R r  
[
\
[ \  
]
^
] _  
_
`
_ o  ���� 0 num  
` m  ���� 
^ m  ���� 
\ o      ���� 0 num  
O 
a
b
a = 
c
d
c o  ���� &0 roundingdirection roundingDirection
d l 
e����
e m  ��
�� MRndRN_U��  ��  
b 
f
g
f l  ?
h
i
j
h Z   ?
k
l��
m
k G   -
n
o
n A   #
p
q
p o   !���� 0 num  
q m  !"����  
o =  &+
r
s
r `  &)
t
u
t o  &'���� 0 num  
u m  '(���� 
s m  )*����  
l r  05
v
w
v _  03
x
y
x o  01���� 0 num  
y m  12���� 
w o      ���� 0 num  ��  
m r  8?
z
{
z [  8=
|
}
| _  8;
~

~ o  89���� 0 num  
 m  9:���� 
} m  ;<���� 
{ o      ���� 0 num  
i   ceil()   
j �
�
�    c e i l ( )
g 
�
�
� = BG
�
�
� o  BC���� &0 roundingdirection roundingDirection
� l CF
�����
� m  CF��
�� MRndRN_D��  ��  
� 
���
� l Ji
�
�
�
� Z  Ji
�
���
�
� G  JW
�
�
� ?  JM
�
�
� o  JK���� 0 num  
� m  KL����  
� =  PU
�
�
� `  PS
�
�
� o  PQ���� 0 num  
� m  QR���� 
� m  ST����  
� r  Z_
�
�
� _  Z]
�
�
� o  Z[���� 0 num  
� m  [\���� 
� o      ���� 0 num  ��  
� r  bi
�
�
� \  bg
�
�
� _  be
�
�
� o  bc���� 0 num  
� m  cd���� 
� m  ef���� 
� o      ���� 0 num  
�   floor()   
� �
�
�    f l o o r ( )��  	� n ly
�
�
� I  qy��
����� >0 throwinvalidparameterconstant throwInvalidParameterConstant
� 
�
�
� o  qr���� &0 roundingdirection roundingDirection
� 
���
� m  ru
�
� �
�
�  b y��  ��  
� o  lq���� 0 _support  	� 
���
� Z  z�
�
�
�
�
� =  z}
�
�
� o  z{���� 0 decimalplaces decimalPlaces
� m  {|����  
� L  ��
�
� _  ��
�
�
� o  ������ 0 num  
� m  ������ 
� 
�
�
� A  ��
�
�
� o  ������ 0 decimalplaces decimalPlaces
� m  ������  
� 
���
� L  ��
�
� _  ��
�
�
� o  ������ 0 num  
� o  ������ 0 themultiplier theMultiplier��  
� L  ��
�
� ^  ��
�
�
� o  ������ 0 num  
� o  ������ 0 themultiplier theMultiplier��  	K R      ��
�
�
�� .ascrerr ****      � ****
� o      ���� 0 etext eText
� ��
�
�
�� 
errn
� o      ���� 0 enumber eNumber
� ��
�
�
�� 
erob
� o      ���� 0 efrom eFrom
� ��
���
�� 
errt
� o      ���� 
0 eto eTo��  	L I  ����
����� 
0 _error  
� 
�
�
� m  ��
�
� �
�
�  r o u n d   n u m b e r
� 
�
�
� o  ������ 0 etext eText
� 
�
�
� o  ������ 0 enumber eNumber
� 
�
�
� o  ������ 0 efrom eFrom
� 
���
� o  ������ 
0 eto eTo��  ��  	< 
�
�
� l     ��������  ��  ��  
� 
�
�
� l     ��������  ��  ��  
� 
�
�
� l     ��
�
���  
� J D--------------------------------------------------------------------   
� �
�
� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
� 
�
�
� l     ��
�
���  
�   Trigonometry   
� �
�
�    T r i g o n o m e t r y
� 
�
�
� l     ��������  ��  ��  
� 
�
�
� i  � �
�
�
� I      ��
����� 0 _sin  
� 
���
� o      ���� 0 x  ��  ��  
� k    
�
� 
�
�
� Z     +
�
�����
� =    
�
�
� `     
�
�
� o     ���� 0 x  
� m    ���� 
� m    ����  
� l   '
�
�
�
� k    '
�
� 
�
�
� Z   
�
�����
� A    
�
�
� o    	���� 0 x  
� m   	 
����  
� r    
�
�
� d    
�
� o    ���� 0 x  
� o      ���� 0 x  ��  ��  
� 
��
� L    '
�
� n   &
�
�
� 4    %�~ 
�~ 
cobj  l   $�}�| [    $ _    " `      o    �{�{ 0 x   m    �z�zh m     !�y�y  m   " #�x�x �}  �|  
� o    �w�w 0 _precalcsine _precalcSine�  
� 1 + performance optimisation for common values   
� � V   p e r f o r m a n c e   o p t i m i s a t i o n   f o r   c o m m o n   v a l u e s��  ��  
� 	
	 l  , 5 r   , 5 ^   , 3 ]   , 1 `   , / o   , -�v�v 0 x   m   - .�u�uh 1   / 0�t
�t 
pi   m   1 2�s�s � o      �r�r 0 x   &   convert from degrees to radians    � @   c o n v e r t   f r o m   d e g r e e s   t o   r a d i a n s
  r   6 ; A   6 9 o   6 7�q�q 0 x   m   7 8�p�p   o      �o�o 0 isneg isNeg  Z  < H �n�m o   < =�l�l 0 isneg isNeg  r   @ D!"! d   @ B## o   @ A�k�k 0 x  " o      �j�j 0 x  �n  �m   $%$ r   I R&'& _   I P()( l  I N*�i�h* ]   I N+,+ o   I J�g�g 0 x  , l  J M-�f�e- ^   J M./. m   J K�d�d / 1   K L�c
�c 
pi  �f  �e  �i  �h  ) m   N O�b�b ' o      �a�a 0 y  % 010 r   S ^232 \   S \454 o   S T�`�` 0 y  5 ]   T [676 l  T Y8�_�^8 _   T Y9:9 ]   T W;<; o   T U�]�] 0 y  < m   U V== ?�      : m   W X�\�\ �_  �^  7 m   Y Z�[�[ 3 o      �Z�Z 0 z  1 >?> Z   _ v@A�Y�X@ =  _ dBCB `   _ bDED o   _ `�W�W 0 z  E m   ` a�V�V C m   b c�U�U A k   g rFF GHG r   g lIJI [   g jKLK o   g h�T�T 0 z  L m   h i�S�S J o      �R�R 0 z  H M�QM r   m rNON [   m pPQP o   m n�P�P 0 y  Q m   n o�O�O O o      �N�N 0 y  �Q  �Y  �X  ? RSR r   w |TUT `   w zVWV o   w x�M�M 0 z  W m   x y�L�L U o      �K�K 0 z  S XYX Z   } �Z[�J�IZ ?   } �\]\ o   } ~�H�H 0 z  ] m   ~ �G�G [ k   � �^^ _`_ r   � �aba H   � �cc o   � ��F�F 0 isneg isNegb o      �E�E 0 isneg isNeg` d�Dd r   � �efe \   � �ghg o   � ��C�C 0 z  h m   � ��B�B f o      �A�A 0 z  �D  �J  �I  Y iji r   � �klk \   � �mnm l  � �o�@�?o \   � �pqp l  � �r�>�=r \   � �sts o   � ��<�< 0 x  t ]   � �uvu o   � ��;�; 0 y  v m   � �ww ?�!�?��v�>  �=  q ]   � �xyx o   � ��:�: 0 y  y m   � �zz >dD,���J�@  �?  n ]   � �{|{ o   � ��9�9 0 y  | m   � �}} <�F���P�l o      �8�8 0 z2  j ~~ r   � ���� ]   � ���� o   � ��7�7 0 z2  � o   � ��6�6 0 z2  � o      �5�5 0 zz   ��� Z   ����4�� G   � ���� =  � ���� o   � ��3�3 0 z  � m   � ��2�2 � =  � ���� o   � ��1�1 0 z  � m   � ��0�0 � r   � ���� [   � ���� \   � ���� m   � ��� ?�      � ^   � ���� o   � ��/�/ 0 zz  � m   � ��.�. � ]   � ���� ]   � ���� o   � ��-�- 0 zz  � o   � ��,�, 0 zz  � l  � ���+�*� [   � ���� ]   � ���� l  � ���)�(� \   � ���� ]   � ���� l  � ���'�&� [   � ���� ]   � ���� l  � ���%�$� \   � ���� ]   � ���� l  � ���#�"� [   � ���� ]   � ���� m   � ��� ���I���� o   � ��!�! 0 zz  � m   � ��� >!�{N>��#  �"  � o   � �� �  0 zz  � m   � ��� >�~O~�K��%  �$  � o   � ��� 0 zz  � m   � ��� >���D��'  �&  � o   � ��� 0 zz  � m   � ��� ?V�l�=��)  �(  � o   � ��� 0 zz  � m   � ��� ?�UUUV��+  �*  � o      �� 0 y  �4  � r   ���� [   �	��� o   � ��� 0 z2  � ]   ���� ]   � ���� o   � ��� 0 z2  � o   � ��� 0 zz  � l  ����� \   ���� ]   ���� l  ����� [   ���� ]   � ���� l  � ����� \   � ���� ]   � ���� l  � ����� [   � ���� ]   � ���� l  � ����� \   � ���� ]   � ���� m   � ��� =���ќ�� o   � ��� 0 zz  � m   � ��� >Z��)[�  �  � o   � ��� 0 zz  � m   � ��� >��V}H��  �  � o   � ��� 0 zz  � m   � ��� ?*�����  �  � o   � ��� 0 zz  � m   � �� ?�"w�  �  � o  �
�
 0 zz  � m  �� ?�UUUU�?�  �  � o      �	�	 0 y  � ��� Z ����� o  �� 0 isneg isNeg� r  ��� d  �� o  �� 0 y  � o      �� 0 y  �  �  � ��� L  �� o  �� 0 y  �  
� ��� l     �� ���  �   ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I     �����
�� .Mth:Sin_null���     doub� o      ���� 0 n  ��  � Q     ���� L    �� I    ������� 0 _sin  � ���� c    ��� o    ���� 0 x  � m    ��
�� 
nmbr��  ��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� �� 
�� 
errn  o      ���� 0 enumber eNumber ��
�� 
erob o      ���� 0 efrom eFrom ����
�� 
errt o      ���� 
0 eto eTo��  � I    ������ 
0 _error    m     �		  s i n 

 o    ���� 0 etext eText  o    ���� 0 enumber eNumber  o    ���� 0 efrom eFrom �� o    ���� 
0 eto eTo��  ��  �  l     ��������  ��  ��    l     ��������  ��  ��    i  � � I     ����
�� .Mth:Cos_null���     doub o      ���� 0 n  ��   Q       L     I    ������ 0 _sin   �� [    	 !  l   "����" c    #$# o    ���� 0 n  $ m    ��
�� 
nmbr��  ��  ! m    ���� Z��  ��   R      ��%&
�� .ascrerr ****      � ****% o      ���� 0 etext eText& ��'(
�� 
errn' o      ���� 0 enumber eNumber( ��)*
�� 
erob) o      ���� 0 efrom eFrom* ��+��
�� 
errt+ o      ���� 
0 eto eTo��   I     ��,���� 
0 _error  , -.- m    // �00  c o s. 121 o    ���� 0 etext eText2 343 o    ���� 0 enumber eNumber4 565 o    ���� 0 efrom eFrom6 7��7 o    ���� 
0 eto eTo��  ��   898 l     ��������  ��  ��  9 :;: l     ��������  ��  ��  ; <=< i  � �>?> I     ��@��
�� .Mth:Tan_null���     doub@ o      ���� 0 n  ��  ? Q    4ABCA k   DD EFE r    GHG c    IJI o    ���� 0 n  J m    ��
�� 
nmbrH o      ���� 0 x  F KLK Z   	 OMN����M =  	 OPO `   	 QRQ o   	 
���� 0 x  R m   
 ���� P m    ����  N l   KSTUS k    KVV WXW Z   YZ����Y A    [\[ o    ���� 0 x  \ m    ����  Z r    ]^] d    __ o    ���� 0 x  ^ o      ���� 0 x  ��  ��  X `a` Z    :bc����b G     +ded =    #fgf o     !���� 0 x  g m   ! "���� Ze =  & )hih o   & '���� 0 x  i m   ' (����c R   . 6��jk
�� .ascrerr ****      � ****j m   4 5ll �mm F I n v a l i d   n u m b e r   ( r e s u l t   w o u l d   b e  " ) .k ��no
�� 
errnn m   0 1�����Yo ��p��
�� 
erobp o   2 3���� 0 x  ��  ��  ��  a q��q L   ; Krr n  ; Jsts 4   @ I��u
�� 
cobju l  A Hv����v [   A Hwxw _   A Fyzy `   A D{|{ o   A B���� 0 x  | m   B C����hz m   D E���� x m   F G���� ��  ��  t o   ; @���� "0 _precalctangent _precalcTangent��  T 1 + performance optimisation for common values   U �}} V   p e r f o r m a n c e   o p t i m i s a t i o n   f o r   c o m m o n   v a l u e s��  ��  L ~~ l  P Y���� r   P Y��� ^   P W��� ]   P U��� `   P S��� o   P Q���� 0 x  � m   Q R����h� 1   S T��
�� 
pi  � m   U V���� �� o      ���� 0 x  � &   convert from degrees to radians   � ��� @   c o n v e r t   f r o m   d e g r e e s   t o   r a d i a n s ��� r   Z _��� A   Z ]��� o   Z [���� 0 x  � m   [ \����  � o      ���� 0 isneg isNeg� ��� Z  ` l������� o   ` a���� 0 isneg isNeg� r   d h��� d   d f�� o   d e���� 0 x  � o      ���� 0 x  ��  ��  � ��� r   m v��� _   m t��� l  m r������ ^   m r��� o   m n���� 0 x  � l  n q������ ^   n q��� 1   n o��
�� 
pi  � m   o p���� ��  ��  ��  ��  � m   r s�� � o      �~�~ 0 y  � ��� r   w ���� \   w ���� o   w x�}�} 0 y  � ]   x ��� l  x }��|�{� _   x }��� ]   x {��� o   x y�z�z 0 y  � m   y z�� ?�      � m   { |�y�y �|  �{  � m   } ~�x�x � o      �w�w 0 z  � ��� Z   � ����v�u� =  � ���� `   � ���� o   � ��t�t 0 z  � m   � ��s�s � m   � ��r�r � k   � ��� ��� r   � ���� [   � ���� o   � ��q�q 0 z  � m   � ��p�p � o      �o�o 0 z  � ��n� r   � ���� [   � ���� o   � ��m�m 0 y  � m   � ��l�l � o      �k�k 0 y  �n  �v  �u  � ��� r   � ���� \   � ���� l  � ���j�i� \   � ���� l  � ���h�g� \   � ���� o   � ��f�f 0 x  � ]   � ���� o   � ��e�e 0 y  � m   � ��� ?�!�P M�h  �g  � ]   � ���� o   � ��d�d 0 y  � m   � ��� >A�`  �j  �i  � ]   � ���� o   � ��c�c 0 y  � m   � ��� <��&3\� o      �b�b 0 z2  � ��� r   � ���� ]   � ���� o   � ��a�a 0 z2  � o   � ��`�` 0 z2  � o      �_�_ 0 zz  � ��� Z   � ����^�� ?   � ���� o   � ��]�] 0 zz  � m   � ��� =����+�� r   � ���� [   � ���� o   � ��\�\ 0 z2  � ^   � ���� ]   � ���� ]   � ���� o   � ��[�[ 0 z2  � o   � ��Z�Z 0 zz  � l  � ���Y�X� \   � ���� ]   � ���� l  � ���W�V� [   � ���� ]   � ���� m   � ��� �ɒ��O?D� o   � ��U�U 0 zz  � m   � ��� A1������W  �V  � o   � ��T�T 0 zz  � m   � �   Aq��)�y�Y  �X  � l  � ��S�R \   � � ]   � � l  � ��Q�P [   � � ]   � �	
	 l  � ��O�N \   � � ]   � � l  � ��M�L [   � � o   � ��K�K 0 zz   m   � � @ʸ��et�M  �L   o   � ��J�J 0 zz   m   � � A4'�X*���O  �N  
 o   � ��I�I 0 zz   m   � � Awُ�����Q  �P   o   � ��H�H 0 zz   m   � � A���<�Z6�S  �R  � o      �G�G 0 y  �^  � r   � � o   � ��F�F 0 z2   o      �E�E 0 y  �  Z  ��D�C G   � =  � �  o   � ��B�B 0 z    m   � ��A�A  =  � !"! o   � ��@�@ 0 z  " m   � ��?�?  r  
#$# ^  %&% m  �>�>��& o  �=�= 0 y  $ o      �<�< 0 y  �D  �C   '(' Z )*�;�:) o  �9�9 0 isneg isNeg* r  +,+ d  -- o  �8�8 0 y  , o      �7�7 0 y  �;  �:  ( .�6. L  // o  �5�5 0 y  �6  B R      �401
�4 .ascrerr ****      � ****0 o      �3�3 0 etext eText1 �223
�2 
errn2 o      �1�1 0 enumber eNumber3 �045
�0 
erob4 o      �/�/ 0 efrom eFrom5 �.6�-
�. 
errt6 o      �,�, 
0 eto eTo�-  C I  &4�+7�*�+ 
0 _error  7 898 m  '*:: �;;  t a n9 <=< o  *+�)�) 0 etext eText= >?> o  +,�(�( 0 enumber eNumber? @A@ o  ,-�'�' 0 efrom eFromA B�&B o  -.�%�% 
0 eto eTo�&  �*  = CDC l     �$�#�"�$  �#  �"  D EFE l     �!� ��!  �   �  F GHG l     �IJ�  I  -----   J �KK 
 - - - - -H LML l     �NO�  N   inverse   O �PP    i n v e r s eM QRQ l     ����  �  �  R STS i  � �UVU I      �W�� 	0 _asin  W X�X o      �� 0 n  �  �  V k     �YY Z[Z r     \]\ A     ^_^ o     �� 0 x  _ m    ��  ] o      �� 0 isneg isNeg[ `a` Z   bc��b o    �� 0 isneg isNegc r   
 ded d   
 ff o   
 �� 0 x  e o      �� 0 x  �  �  a ghg Z   %ij��i ?    klk o    �� 0 x  l m    �
�
 j R    !�	mn
�	 .ascrerr ****      � ****m m     oo �pp T I n v a l i d   n u m b e r   ( n o t   b e t w e e n   - 1 . 0   a n d   1 . 0 ) .n �qr
� 
errnq m    ���Yr �s�
� 
erobs o    �� 0 x  �  �  �  h tut Z   & �vwxyv ?   & )z{z o   & '�� 0 x  { m   ' (|| ?�      w k   , }} ~~ r   , 1��� \   , /��� m   , -�� � o   - .�� 0 x  � o      � �  0 zz   ��� r   2 W��� ^   2 U��� ]   2 E��� o   2 3���� 0 zz  � l  3 D������ [   3 D��� ]   3 B��� l  3 @������ \   3 @��� ]   3 >��� l  3 <������ [   3 <��� ]   3 :��� l  3 8������ \   3 8��� ]   3 6��� m   3 4�� ?hOØ��� o   4 5���� 0 zz  � m   6 7�� ?��Y�,���  ��  � o   8 9���� 0 zz  � m   : ;�� @����?���  ��  � o   < =���� 0 zz  � m   > ?�� @9����"��  ��  � o   @ A���� 0 zz  � m   B C�� @<�b@����  ��  � l  E T������ [   E T��� ]   E R��� l  E P������ \   E P��� ]   E N��� l  E L������ [   E L��� ]   E J��� l  E H������ \   E H��� o   E F���� 0 zz  � m   F G�� @5򢶿]R��  ��  � o   H I���� 0 zz  � m   J K�� @bb�j1��  ��  � o   L M���� 0 zz  � m   N O�� @w���c���  ��  � o   P Q���� 0 zz  � m   R S�� @ug	��D���  ��  � o      ���� 0 p  � ��� r   X _��� a   X ]��� l  X [������ [   X [��� o   X Y���� 0 zz  � o   Y Z���� 0 zz  ��  ��  � m   [ \�� ?�      � o      ���� 0 zz  � ��� r   ` i��� \   ` g��� l  ` e������ ^   ` e��� 1   ` c��
�� 
pi  � m   c d���� ��  ��  � o   e f���� 0 zz  � o      ���� 0 z  � ��� r   j s��� \   j q��� ]   j m��� o   j k���� 0 zz  � o   k l���� 0 p  � m   m p�� <��&3\
� o      ���� 0 zz  � ���� r   t ��� [   t }��� \   t w��� o   t u���� 0 z  � o   u v���� 0 zz  � l  w |������ ^   w |��� 1   w z��
�� 
pi  � m   z {���� ��  ��  � o      ���� 0 z  ��  x ��� A   � ���� o   � ����� 0 x  � m   � ��� >Ey��0�:� ���� r   � ���� o   � ����� 0 x  � o      ���� 0 z  ��  y k   � ��� ��� r   � ���� ]   � ���� o   � ����� 0 x  � o   � ����� 0 x  � o      ���� 0 zz  � ���� r   � ���� [   � ���� ]   � ���� ^   � ���� ]   � ���� o   � ����� 0 zz  � l  � ������� \   � ���� ]   � ���� l  � � ����  [   � � ]   � � l  � ����� \   � � ]   � �	 l  � �
����
 [   � � ]   � � l  � ����� \   � � ]   � � m   � � ?qk��v� o   � ����� 0 zz   m   � � ?�CA3>M���  ��   o   � ����� 0 zz   m   � � @�K�/��  ��  	 o   � ����� 0 zz   m   � � @0C1�'����  ��   o   � ����� 0 zz   m   � � @3��w����  ��  � o   � ����� 0 zz  � m   � � @ elΰ8��  ��  � l  � ����� \   � � ]   � � l  � ����� [   � � !  ]   � �"#" l  � �$����$ \   � �%&% ]   � �'(' l  � �)����) [   � �*+* ]   � �,-, l  � �.����. \   � �/0/ o   � ����� 0 zz  0 m   � �11 @-{Y^���  ��  - o   � ����� 0 zz  + m   � �22 @Q��%��6��  ��  ( o   � ����� 0 zz  & m   � �33 @be�m5v���  ��  # o   � ����� 0 zz  ! m   � �44 @apV������  ��   o   � ����� 0 zz   m   � �55 @H�"
6���  ��  � o   � ����� 0 x  � o   � ����� 0 x  � o      ���� 0 z  ��  u 676 Z  � �89����8 o   � ����� 0 isneg isNeg9 r   � �:;: d   � �<< o   � ����� 0 z  ; o      ���� 0 z  ��  ��  7 =��= L   � �>> ^   � �?@? o   � ����� 0 z  @ l  � �A����A ^   � �BCB 1   � ���
�� 
pi  C m   � ����� ���  ��  ��  T DED l     ��������  ��  ��  E FGF l     ��������  ��  ��  G HIH l     ��������  ��  ��  I JKJ i  LML I     ��N��
�� .Mth:Sinanull���     doubN o      ���� 0 n  ��  M Q     OPQO L    RR I    ��S���� 	0 _asin  S T��T c    UVU o    ���� 0 n  V m    ��
�� 
nmbr��  ��  P R      ��WX
�� .ascrerr ****      � ****W o      ���� 0 etext eTextX ��YZ
�� 
errnY o      ���� 0 enumber eNumberZ ��[\
�� 
erob[ o      ���� 0 efrom eFrom\ ��]��
�� 
errt] o      ���� 
0 eto eTo��  Q I    ��^��� 
0 _error  ^ _`_ m    aa �bb  a s i n` cdc o    �~�~ 0 etext eTextd efe o    �}�} 0 enumber eNumberf ghg o    �|�| 0 efrom eFromh i�{i o    �z�z 
0 eto eTo�{  �  K jkj l     �y�x�w�y  �x  �w  k lml l     �v�u�t�v  �u  �t  m non i pqp I     �sr�r
�s .Mth:Cosanull���     doubr o      �q�q 0 n  �r  q Q      stus L    vv \    wxw m    �p�p Zx l   y�o�ny I    �mz�l�m 	0 _asin  z {�k{ c    |}| o    �j�j 0 n  } m    �i
�i 
nmbr�k  �l  �o  �n  t R      �h~
�h .ascrerr ****      � ****~ o      �g�g 0 etext eText �f��
�f 
errn� o      �e�e 0 enumber eNumber� �d��
�d 
erob� o      �c�c 0 efrom eFrom� �b��a
�b 
errt� o      �`�` 
0 eto eTo�a  u I     �_��^�_ 
0 _error  � ��� m    �� ���  a c o s� ��� o    �]�] 0 etext eText� ��� o    �\�\ 0 enumber eNumber� ��� o    �[�[ 0 efrom eFrom� ��Z� o    �Y�Y 
0 eto eTo�Z  �^  o ��� l     �X�W�V�X  �W  �V  � ��� l     �U�T�S�U  �T  �S  � ��� i ��� I     �R��Q
�R .Mth:Tananull���     doub� o      �P�P 0 n  �Q  � Q     *���� k    �� ��� r    ��� c    ��� o    �O�O 0 n  � m    �N
�N 
nmbr� o      �M�M 0 x  � ��L� L   	 �� I   	 �K��J�K 	0 _asin  � ��I� ^   
 ��� o   
 �H�H 0 x  � l   ��G�F� a    ��� l   ��E�D� [    ��� ]    ��� o    �C�C 0 x  � o    �B�B 0 x  � m    �A�A �E  �D  � m    �� ?�      �G  �F  �I  �J  �L  � R      �@��
�@ .ascrerr ****      � ****� o      �?�? 0 etext eText� �>��
�> 
errn� o      �=�= 0 enumber eNumber� �<��
�< 
erob� o      �;�; 0 efrom eFrom� �:��9
�: 
errt� o      �8�8 
0 eto eTo�9  � I     *�7��6�7 
0 _error  � ��� m   ! "�� ���  a t a n� ��� o   " #�5�5 0 etext eText� ��� o   # $�4�4 0 enumber eNumber� ��� o   $ %�3�3 0 efrom eFrom� ��2� o   % &�1�1 
0 eto eTo�2  �6  � ��� l     �0�/�.�0  �/  �.  � ��� l     �-�,�+�-  �,  �+  � ��� l     �*���*  �  -----   � ��� 
 - - - - -� ��� l     �)���)  �   hyperbolic   � ���    h y p e r b o l i c� ��� l     �(�'�&�(  �'  �&  � ��� i ��� I     �%��$
�% .Mth:Sinhnull���     doub� o      �#�# 0 n  �$  � Q     .���� k    �� ��� r    ��� c    ��� o    �"�" 0 n  � m    �!
�! 
nmbr� o      � �  0 x  � ��� L   	 �� ]   	 ��� m   	 
�� ?�      � l  
 ���� \   
 ��� a   
 ��� o   
 �� 	0 __e__  � o    �� 0 x  � a    ��� o    �� 	0 __e__  � d    �� o    �� 0 x  �  �  �  � R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo�  � I   $ .���� 
0 _error  � ��� m   % &�� ��� 
 a s i n h� ��� o   & '�� 0 etext eText�    o   ' (�� 0 enumber eNumber  o   ( )�� 0 efrom eFrom �
 o   ) *�	�	 
0 eto eTo�
  �  �  l     ����  �  �    l     ����  �  �   	
	 i  I     ��
� .Mth:Coshnull���     doub o      � �  0 n  �   Q     . k      r     c     o    ���� 0 n   m    ��
�� 
nmbr o      ���� 0 x   �� L   	  ]   	  m   	 
 ?�       l  
 ���� [   
  a   
  !  o   
 ���� 	0 __e__  ! o    ���� 0 x   a    "#" o    ���� 	0 __e__  # d    $$ o    ���� 0 x  ��  ��  ��   R      ��%&
�� .ascrerr ****      � ****% o      ���� 0 etext eText& ��'(
�� 
errn' o      ���� 0 enumber eNumber( ��)*
�� 
erob) o      ���� 0 efrom eFrom* ��+��
�� 
errt+ o      ���� 
0 eto eTo��   I   $ .��,���� 
0 _error  , -.- m   % &// �00 
 a c o s h. 121 o   & '���� 0 etext eText2 343 o   ' (���� 0 enumber eNumber4 565 o   ( )���� 0 efrom eFrom6 7��7 o   ) *���� 
0 eto eTo��  ��  
 898 l     ��������  ��  ��  9 :;: l     ��������  ��  ��  ; <=< i >?> I     ��@��
�� .Mth:Tanhnull���     doub@ o      ���� 0 n  ��  ? Q     =ABCA k    +DD EFE r    GHG c    IJI o    ���� 0 n  J m    ��
�� 
nmbrH o      ���� 0 x  F K��K L   	 +LL ^   	 *MNM l  	 O����O \   	 PQP a   	 RSR o   	 ���� 	0 __e__  S o    ���� 0 x  Q a    TUT o    ���� 	0 __e__  U d    VV o    ���� 0 x  ��  ��  N l   )W����W [    )XYX a     Z[Z o    ���� 	0 __e__  [ o    ���� 0 x  Y a     (\]\ o     %���� 	0 __e__  ] d   % '^^ o   % &���� 0 x  ��  ��  ��  B R      ��_`
�� .ascrerr ****      � ****_ o      ���� 0 etext eText` ��ab
�� 
errna o      ���� 0 enumber eNumberb ��cd
�� 
erobc o      ���� 0 efrom eFromd ��e��
�� 
errte o      ���� 
0 eto eTo��  C I   3 =��f���� 
0 _error  f ghg m   4 5ii �jj 
 a t a n hh klk o   5 6���� 0 etext eTextl mnm o   6 7���� 0 enumber eNumbern opo o   7 8���� 0 efrom eFromp q��q o   8 9���� 
0 eto eTo��  ��  = rsr l     ��������  ��  ��  s tut l     ��������  ��  ��  u vwv l     ��xy��  x J D--------------------------------------------------------------------   y �zz � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -w {|{ l     ��}~��  }   Logarithms   ~ �    L o g a r i t h m s| ��� l     ��������  ��  ��  � ��� i ��� I      ������� 
0 _frexp  � ���� o      ���� 0 m  ��  ��  � k     n�� ��� Z    ������� =    ��� o     ���� 0 m  � m    ����  � L    �� J    
�� ��� m    ��         � ���� m    ����  ��  ��  ��  � ��� r    ��� A    ��� o    ���� 0 m  � m    ����  � o      ���� 0 isneg isNeg� ��� Z   "������� o    ���� 0 isneg isNeg� r    ��� d    �� o    ���� 0 m  � o      ���� 0 m  ��  ��  � ��� r   # &��� m   # $����  � o      ���� 0 e  � ��� W   ' [��� Z   7 V������ @   7 :��� o   7 8���� 0 m  � m   8 9���� � k   = H�� ��� r   = B��� ^   = @��� o   = >���� 0 m  � m   > ?���� � o      ���� 0 m  � ���� r   C H��� [   C F��� o   C D���� 0 e  � m   D E���� � o      ���� 0 e  ��  ��  � k   K V�� ��� r   K P��� ]   K N��� o   K L���� 0 m  � m   L M���� � o      ���� 0 m  � ���� r   Q V��� \   Q T��� o   Q R���� 0 e  � m   R S���� � o      ���� 0 e  ��  � F   + 6��� @   + .��� o   + ,���� 0 m  � m   , -�� ?�      � A   1 4��� o   1 2���� 0 m  � m   2 3���� � ��� Z  \ h������� o   \ ]���� 0 isneg isNeg� r   ` d��� d   ` b�� o   ` a���� 0 m  � o      ���� 0 m  ��  ��  � ���� L   i n�� J   i m�� ��� o   i j���� 0 m  � ���� o   j k���� 0 e  ��  ��  � ��� l     ����~��  �  �~  � ��� l     �}�|�{�}  �|  �{  � ��� i ��� I      �z��y�z 	0 _logn  � ��x� o      �w�w 0 x  �x  �y  � k    ;�� ��� Z    ���v�u� B     ��� o     �t�t 0 x  � m    �s�s  � R    �r��
�r .ascrerr ****      � ****� m   
 �� ��� 8 I n v a l i d   n u m b e r   ( m u s t   b e   > 0 ) .� �q��p
�q 
errn� m    	�o�o�Y�p  �v  �u  � ��� r    &��� I      �n��m�n 
0 _frexp  � ��l� o    �k�k 0 x  �l  �m  � J      �� ��� o      �j�j 0 x  � ��i� o      �h�h 0 e  �i  � ��� Z   '8���g�� G   ' 2   A   ' * o   ' (�f�f 0 e   m   ( )�e�e�� ?   - 0 o   - .�d�d 0 e   m   . /�c�c � k   5 �  Z   5 ^	
�b	 A   5 8 o   5 6�a�a 0 x   m   6 7 ?栞fK�
 l  ; N k   ; N  r   ; @ \   ; > o   ; <�`�` 0 e   m   < =�_�_  o      �^�^ 0 e    r   A F \   A D o   A B�]�] 0 x   m   B C ?�       o      �\�\ 0 z    �[  r   G N!"! [   G L#$# ]   G J%&% m   G H'' ?�      & o   H I�Z�Z 0 z  $ m   J K(( ?�      " o      �Y�Y 0 y  �[     (2 ^ 0.5) / 2    �))    ( 2   ^   0 . 5 )   /   2�b   k   Q ^** +,+ r   Q V-.- \   Q T/0/ o   Q R�X�X 0 x  0 m   R S�W�W . o      �V�V 0 z  , 1�U1 r   W ^232 [   W \454 ]   W Z676 m   W X88 ?�      7 o   X Y�T�T 0 x  5 m   Z [99 ?�      3 o      �S�S 0 y  �U   :;: r   _ d<=< ^   _ b>?> o   _ `�R�R 0 z  ? o   ` a�Q�Q 0 y  = o      �P�P 0 x  ; @A@ r   e jBCB ]   e hDED o   e f�O�O 0 x  E o   f g�N�N 0 x  C o      �M�M 0 z  A FGF r   k �HIH ^   k �JKJ ]   k xLML ]   k nNON o   k l�L�L 0 x  O o   l m�K�K 0 z  M l  n wP�J�IP \   n wQRQ ]   n uSTS l  n sU�H�GU [   n sVWV ]   n qXYX m   n oZZ ��D=�l�Y o   o p�F�F 0 z  W m   q r[[ @0b�s{��H  �G  T o   s t�E�E 0 z  R m   u v\\ @P	"*?�J  �I  K l  x �]�D�C] \   x �^_^ ]   x �`a` l  x b�B�Ab [   x cdc ]   x }efe l  x {g�@�?g \   x {hih o   x y�>�> 0 z  i m   y zjj @A�C�l��@  �?  f o   { |�=�= 0 z  d m   } ~kk @s��*�
�B  �A  a o    ��<�< 0 z  _ m   � �ll @���?;�D  �C  I o      �;�; 0 z  G mnm r   � �opo o   � ��:�: 0 e  p o      �9�9 0 y  n q�8q r   � �rsr [   � �tut [   � �vwv \   � �xyx o   � ��7�7 0 z  y ]   � �z{z o   � ��6�6 0 y  { m   � �|| ?+�\a�w o   � ��5�5 0 x  u ]   � �}~} o   � ��4�4 0 e  ~ m   � � ?�0     s o      �3�3 0 z  �8  �g  � k   �8�� ��� Z   � ����2�� A   � ���� o   � ��1�1 0 x  � m   � ��� ?栞fK�� l  � ����� k   � ��� ��� r   � ���� \   � ���� o   � ��0�0 0 e  � m   � ��/�/ � o      �.�. 0 e  � ��-� r   � ���� \   � ���� ]   � ���� m   � ��,�, � o   � ��+�+ 0 x  � m   � ��*�* � o      �)�) 0 x  �-  �   (2 ^ 0.5) / 2   � ���    ( 2   ^   0 . 5 )   /   2�2  � r   � ���� \   � ���� o   � ��(�( 0 x  � m   � ��'�' � o      �&�& 0 x  � ��� r   � ���� ]   � ���� o   � ��%�% 0 x  � o   � ��$�$ 0 x  � o      �#�# 0 z  � ��� r   ���� ^   ���� ]   � ���� ]   � ���� o   � ��"�" 0 x  � o   � ��!�! 0 z  � l  � ��� �� [   � ���� ]   � ���� l  � ����� [   � ���� ]   � ���� l  � ����� [   � ���� ]   � ���� l  � ����� [   � ���� ]   � ���� l  � ����� [   � ���� ]   � ���� m   � ��� ?���� o   � ��� 0 x  � m   � ��� ?���?Vd��  �  � o   � ��� 0 x  � m   � ��� @Һ�i��  �  � o   � ��� 0 x  � m   � ��� @,�r�>���  �  � o   � ��� 0 x  � m   � ��� @1�֒K�R�  �  � o   � ��� 0 x  � m   � ��� @�c}~ݝ�   �  � l  ����� [   ���� ]   � ���� l  � ����� [   � ���� ]   � ���� l  � ����� [   � ���� ]   � ���� l  � ����
� [   � ���� ]   � ���� l  � ���	�� [   � ���� o   � ��� 0 x  � m   � ��� @&� ����	  �  � o   � ��� 0 x  � m   � ��� @F�,N��  �
  � o   � ��� 0 x  � m   � ��� @T�3�&���  �  � o   � ��� 0 x  � m   � ��� @Q���^��  �  � o   � ��� 0 x  � m   � �� @7 
�&5�  �  � o      �� 0 y  � ��� Z  ���� � >  ��� o  ���� 0 e  � m  ����  � r  ��� \  ��� o  ���� 0 y  � ]  ��� o  ���� 0 e  � m  �� ?+�\a�� o      ���� 0 y  �  �   � ��� r  ��� \  ��� o  ���� 0 y  � l ������ ^  ��� o  ���� 0 z  � m  ���� ��  ��  � o      ���� 0 y  �    r  $ [  " o   ���� 0 x   o   !���� 0 y   o      ���� 0 z   �� Z %8���� >  %(	
	 o  %&���� 0 e  
 m  &'����   r  +4 [  +2 o  +,���� 0 z   ]  ,1 o  ,-���� 0 e   m  -0 ?�0      o      ���� 0 z  ��  ��  ��  � �� L  9; o  9:���� 0 z  ��  �  l     ��������  ��  ��    l     ��������  ��  ��    l     ��������  ��  ��    i  # I     ����
�� .Mth:Lognnull���     doub o      ���� 0 n  ��   Q      ! L    "" I    ��#���� 	0 _logn  # $��$ c    %&% o    ���� 0 n  & m    ��
�� 
nmbr��  ��    R      ��'(
�� .ascrerr ****      � ****' o      ���� 0 etext eText( ��)*
�� 
errn) o      ���� 0 enumber eNumber* ��+,
�� 
erob+ o      ���� 0 efrom eFrom, ��-��
�� 
errt- o      ���� 
0 eto eTo��  ! I    ��.���� 
0 _error  . /0/ m    11 �22  l o g n0 343 o    ���� 0 etext eText4 565 o    ���� 0 enumber eNumber6 787 o    ���� 0 efrom eFrom8 9��9 o    ���� 
0 eto eTo��  ��   :;: l     ��������  ��  ��  ; <=< l     ��������  ��  ��  = >?> i $'@A@ I     ��B��
�� .Mth:Lo10null���     doubB o      ���� 0 n  ��  A Q     $CDEC l   FGHF L    II ^    JKJ ]    LML l   N����N ^    OPO I    ��Q���� 	0 _logn  Q R��R c    STS o    ���� 0 n  T m    ��
�� 
nmbr��  ��  P m    UU @k���T���  ��  M m    VV @r�     K m    WW @r�    jG   correct for minor drift   H �XX 0   c o r r e c t   f o r   m i n o r   d r i f tD R      ��YZ
�� .ascrerr ****      � ****Y o      ���� 0 etext eTextZ ��[\
�� 
errn[ o      ���� 0 enumber eNumber\ ��]^
�� 
erob] o      ���� 0 efrom eFrom^ ��_��
�� 
errt_ o      ���� 
0 eto eTo��  E I    $��`���� 
0 _error  ` aba m    cc �dd 
 l o g 1 0b efe o    ���� 0 etext eTextf ghg o    ���� 0 enumber eNumberh iji o    ���� 0 efrom eFromj k��k o     ���� 
0 eto eTo��  ��  ? lml l     ��������  ��  ��  m non l     ��������  ��  ��  o pqp i (+rsr I     ��tu
�� .Mth:Logbnull���     doubt o      ���� 0 n  u ��v��
�� 
Basev o      ���� 0 b  ��  s Q     'wxyw L    zz ^    {|{ I    ��}���� 	0 _logn  } ~��~ c    � o    ���� 0 n  � m    ��
�� 
nmbr��  ��  | l   ������ I    ������� 	0 _logn  � ���� c    ��� o    ���� 0 b  � m    ��
�� 
nmbr��  ��  ��  ��  x R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  y I    '������� 
0 _error  � ��� m    �� ���  l o g b� ��� o     ���� 0 etext eText� ��� o     !���� 0 enumber eNumber� ��� o   ! "���� 0 efrom eFrom� ���� o   " #���� 
0 eto eTo��  ��  q ��� l     ��~�}�  �~  �}  � ��|� l     �{�z�y�{  �z  �y  �|       (�x���� h r����������������������������������x  � &�w�v�u�t�s�r�q�p�o�n�m�l�k�j�i�h�g�f�e�d�c�b�a�`�_�^�]�\�[�Z�Y�X�W�V�U�T�S�R
�w 
pimr�v 0 _support  �u 
0 _error  �t 	0 __e__  �s 0 _isequaldelta _isEqualDelta�r 0 _precalcsine _precalcSine�q "0 _precalctangent _precalcTangent�p ,0 _makenumberformatter _makeNumberFormatter�o $0 _setroundingmode _setRoundingMode�n  0 _nameforformat _nameForFormat�m 60 _canonicalnumberformatter _canonicalNumberFormatter
�l .Mth:FNumnull���     nmbr
�k .Mth:PNumnull���     ctxt
�j .Mth:NuHenull���     ****
�i .Mth:HeNunull���     ctxt
�h .Mth:DeRanull���     doub
�g .Mth:RaDenull���     doub
�f .Mth:Abs_null���     nmbr
�e .Mth:CmpNnull���     ****
�d .Mth:MinNnull���     ****
�c .Mth:MaxNnull���     ****
�b .Mth:RouNnull���     doub�a 0 _sin  
�` .Mth:Sin_null���     doub
�_ .Mth:Cos_null���     doub
�^ .Mth:Tan_null���     doub�] 	0 _asin  
�\ .Mth:Sinanull���     doub
�[ .Mth:Cosanull���     doub
�Z .Mth:Tananull���     doub
�Y .Mth:Sinhnull���     doub
�X .Mth:Coshnull���     doub
�W .Mth:Tanhnull���     doub�V 
0 _frexp  �U 	0 _logn  
�T .Mth:Lognnull���     doub
�S .Mth:Lo10null���     doub
�R .Mth:Logbnull���     doub� �Q��Q �  ��� �P��O
�P 
cobj� ��   �N 
�N 
frmk�O  � �M��L
�M 
cobj� ��   �K
�K 
osax�L  � ��   �J /
�J 
scpt� �I 7�H�G���F�I 
0 _error  �H �E��E �  �D�C�B�A�@�D 0 handlername handlerName�C 0 etext eText�B 0 enumber eNumber�A 0 efrom eFrom�@ 
0 eto eTo�G  � �?�>�=�<�;�? 0 handlername handlerName�> 0 etext eText�= 0 enumber eNumber�< 0 efrom eFrom�; 
0 eto eTo�  G�:�9�: �9 &0 throwcommanderror throwCommandError�F b  ࠡ����+ � �8��8 �   � � � � � � � � � � � � � � � � � � � � � � � �� �7��7 �   � � � � � ��6 � � � � � � � � � � ��5 � � � � �
�6 
msng
�5 
msng� �4"�3�2���1�4 ,0 _makenumberformatter _makeNumberFormatter�3 �0��0 �  �/�.�/ 0 formatstyle formatStyle�. 0 
localecode 
localeCode�2  � �-�,�+�- 0 formatstyle formatStyle�, 0 
localecode 
localeCode�+ 0 asocformatter asocFormatter� �*�)�(�'�&�%�$�#�"�!� ����������������
�* misccura�) &0 nsnumberformatter NSNumberFormatter�( 	0 alloc  �' 0 init  
�& FNStFNS4�% D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle�$ "0 setnumberstyle_ setNumberStyle_
�# FNStFNS0�" 40 nsnumberformatternostyle NSNumberFormatterNoStyle
�! FNStFNS1�  >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyle
� FNStFNS2� @0 nsnumberformattercurrencystyle NSNumberFormatterCurrencyStyle
� FNStFNS3� >0 nsnumberformatterpercentstyle NSNumberFormatterPercentStyle
� FNStFNS5� @0 nsnumberformatterspelloutstyle NSNumberFormatterSpellOutStyle
� 
errn��Y
� 
erob
� 
errt
� 
enum� � *0 asnslocaleparameter asNSLocaleParameter� 0 
setlocale_ 
setLocale_�1 ���,j+ j+ E�O��  ���,k+ Y q��  ���,k+ Y `��  ���,k+ Y O��  ���,k+ Y >��  ���,k+ Y -��  ��a ,k+ Y )a a a �a a a a O�b  �a l+ k+ O�� �������� $0 _setroundingmode _setRoundingMode� ��� �  ��� "0 numberformatter numberFormatter� &0 roundingdirection roundingDirection�  � �
�	�
 "0 numberformatter numberFormatter�	 &0 roundingdirection roundingDirection� ��������� ��������������2��
� MRndRNhE
� misccura� @0 nsnumberformatterroundhalfeven NSNumberFormatterRoundHalfEven� $0 setroundingmode_ setRoundingMode_
� MRndRNhT� @0 nsnumberformatterroundhalfdown NSNumberFormatterRoundHalfDown
� MRndRNhF� <0 nsnumberformatterroundhalfup NSNumberFormatterRoundHalfUp
�  MRndRN_T�� 80 nsnumberformatterrounddown NSNumberFormatterRoundDown
�� MRndRN_F�� 40 nsnumberformatterroundup NSNumberFormatterRoundUp
�� MRndRN_U�� >0 nsnumberformatterroundceiling NSNumberFormatterRoundCeiling
�� MRndRN_D�� :0 nsnumberformatterroundfloor NSNumberFormatterRoundFloor�� >0 throwinvalidparameterconstant throwInvalidParameterConstant� ���  ���,k+ Y u��  ���,k+ Y d��  ���,k+ Y S��  ���,k+ Y B��  ���,k+ Y 1��  ���,k+ Y  ��  ���,k+ Y b  �a l+ � ��<����������  0 _nameforformat _nameForFormat�� ����� �  ���� 0 formatstyle formatStyle��  � ���� 0 formatstyle formatStyle� ��I��R��[��d��m��u|~
�� FNStFNS0
�� FNStFNS1
�� FNStFNS2
�� FNStFNS3
�� FNStFNS4
�� FNStFNS5�� I��  �Y ?��  �Y 4��  �Y )��  �Y ��  �Y ��  �Y �%�%� ������������� 60 _canonicalnumberformatter _canonicalNumberFormatter��  ��  � ���� 0 asocformatter asocFormatter� 	������������������
�� misccura�� &0 nsnumberformatter NSNumberFormatter�� 	0 alloc  �� 0 init  �� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle�� "0 setnumberstyle_ setNumberStyle_�� 0 nslocale NSLocale�� 0 systemlocale systemLocale�� 0 
setlocale_ 
setLocale_�� '��,j+ j+ E�O���,k+ O���,j+ k+ O�� �����������
�� .Mth:FNumnull���     nmbr�� 0 	thenumber 	theNumber�� ����
�� 
Usin� {�������� 0 formatstyle formatStyle��  
�� FNStFNSD� �����
�� 
Loca� {�������� 0 
localecode 
localeCode��  
�� 
msng��  � 	�������������������� 0 	thenumber 	theNumber�� 0 formatstyle formatStyle�� 0 
localecode 
localeCode�� 0 asocformatter asocFormatter�� 0 
asocstring 
asocString�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� ���������������������������������������.����
�� 
kocl
�� 
nmbr
�� .corecnte****       ****�� �� 60 throwinvalidparametertype throwInvalidParameterType
�� FNStFNSD
�� 
pcls
�� 
long
�� FNStFNS0
�� FNStFNS4�� ,0 _makenumberformatter _makeNumberFormatter�� &0 stringfromnumber_ stringFromNumber_
�� 
msng
�� 
errn���Y
�� 
erob
�� 
ctxt�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� � s�kv��l j  b  �����+ Y hO��  ��,�  �E�Y �E�Y hO*��l+ E�O��k+ E�O��  )�a a ��a Y hO�a &W X  *a ����a + � ��>��������
�� .Mth:PNumnull���     ctxt�� 0 thetext theText�� ����
�� 
Usin� {�������� 0 formatstyle formatStyle��  
�� FNStFNSD� �����
�� 
Loca� {�������� 0 
localecode 
localeCode��  
�� 
msng��  � 
���������������������� 0 thetext theText�� 0 formatstyle formatStyle�� 0 
localecode 
localeCode�� 0 asocformatter asocFormatter�� 0 
asocnumber 
asocNumber�� $0 localeidentifier localeIdentifier�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� ������dh����������������������������
�� 
kocl
�� 
ctxt
�� .corecnte****       ****�� �� 60 throwinvalidparametertype throwInvalidParameterType
� FNStFNSD
� FNStFNS4� ,0 _makenumberformatter _makeNumberFormatter� &0 numberfromstring_ numberFromString_
� 
msng� 
0 locale  � $0 localeidentifier localeIdentifier
� 
leng
� 
errn��Y
� 
erob�  0 _nameforformat _nameForFormat
� 
****� 0 etext eText� ��~�
� 
errn�~ 0 enumber eNumber� �}�|�
�} 
erob�| 0 efrom eFrom� �{�z�y
�{ 
errt�z 
0 eto eTo�y  � � 
0 _error  �� � ��kv��l j  b  �����+ Y hO��  �E�Y hO*��l+ 	E�O��k+ 
E�O��  N�j+ j+ �&E�O��,j  �E�Y a �%a %E�O)a a a ��a *�k+ %a %�%a %Y hO�a &W X  *a ����a + � �x��w�v���u
�x .Mth:NuHenull���     ****�w 0 	thenumber 	theNumber�v �t��
�t 
Plac� {�s�r�q�s 0 	chunksize 	chunkSize�r  �q  � �p��o
�p 
Pref� {�n�m�l�n 0 	hasprefix 	hasPrefix�m  
�l boovfals�o  � �k�j�i�h�g�f�e�d�c�b�a�`�_�^�k 0 	thenumber 	theNumber�j 0 	chunksize 	chunkSize�i 0 	hasprefix 	hasPrefix�h 0 hextext hexText�g 0 	hexprefix 	hexPrefix�f 0 padtext padText�e 0 maxsize maxSize�d 0 
resultlist 
resultList�c 0 aref aRef�b 0 oldtids oldTIDs�a 0 etext eText�` 0 enumber eNumber�_ 0 efrom eFrom�^ 
0 eto eTo� >�]�\�[�Z�Y:�X�W�VS�UX�T�S^�R|���Q��������P�O�"'1D�NH��M�L�K�J�I�H��������G�F�E���D��C�B�] (0 asintegerparameter asIntegerParameter�\ (0 asbooleanparameter asBooleanParameter
�[ 
kocl
�Z 
list
�Y .corecnte****       ****�X 00 aswholenumberparameter asWholeNumberParameter�W 
�V 
bool
�U 
long�T �S .0 throwinvalidparameter throwInvalidParameter�R���Q 
�P 
cobj
�O 
leng�N 0 
resultlist 
resultList� �A��@�?���>
�A .ascrinit****      � ****� k     	�� H�=�=  �@  �?  � �<�< 
0 _list_  � �;�:
�; 
cobj�: 
0 _list_  �> 
b   �-E��M 
0 _list_  
�L 
pcnt
�K 
doub
�J 
errn�I�\�H  � �9�8�7
�9 
errn�8�\�7  
�G 
ctxt
�F 
ascr
�E 
txdl�D 0 etext eText� �6�5�
�6 
errn�5 0 enumber eNumber� �4�3�
�4 
erob�3 0 efrom eFrom� �2�1�0
�2 
errt�1 
0 eto eTo�0  �C �B 
0 _error  �u��b  ��l+ E�Ob  ��l+ E�O�kv��l j b  ��l+ E�O�j
 ���& b  �����+ Y hOa E�O�j I�j	 �a �$�& (b  �a �a a �$%a %a �$k%�+ Y hOa E�O�'E�Y Ca E�O�j	 �a �$k�& (b  �a �a a �$%a %a �$k%�+ Y hO� �a %E�Y hO &h�ja a �a #k/�%E�O�a "E�[OY��O h�a ,�a �%E�[OY��O��%Y{�k
 ���& b  �a  �a !�+ Y hOa "a �$klvE[a k/E�Z[a l/E�ZO �kh�a #%E�[OY��Oa $a %K &S�O ӧa ',[�a l kh  ;�a (,�&E�O��a (,a )&
 �j�&
 ���& )a *a +lhY hW :X , -�� b  �a .�a /a �$k%�+ Y b  �a 0�a 1�+ Oa 2E�O &h�ja 3a �a #k/�%E�O�a "E�[OY��O��%[a 4\[Z�'\Zi2�a (,F[OY�AO_ 5a 6,E�Oa 7_ 5a 6,FO� a 8�a ',%E�Y �a ',a 4&E�O�_ 5a 6,FO�W X 9 :*a ;����a <+ =� �/�.�-���,
�/ .Mth:HeNunull���     ctxt�. 0 hextext hexText�- �+��
�+ 
Plac� {�*�)�(�* 0 	chunksize 	chunkSize�)  �(  � �'��&
�' 
Prec� {�%�$�#�% 0 	isprecise 	isPrecise�$  
�# boovtrue�&  � �"�!� ����������" 0 hextext hexText�! 0 	chunksize 	chunkSize�  0 	isprecise 	isPrecise� 0 	thenumber 	theNumber� 0 
isnegative 
isNegative� 0 charref charRef� 0 i  � 0 
resultlist 
resultList� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� 2#$0�<���O�T��a�}������
�	������������� �����$.[����������� "0 astextparameter asTextParameter� (0 asintegerparameter asIntegerParameter� 
� 
bool
� 
long� � .0 throwinvalidparameter throwInvalidParameter� (0 asbooleanparameter asBooleanParameter
� 
ctxt
� 
kocl
� 
cobj
� .corecnte****       ****�
 
�	 misccura
� 
psof
� 
psin
� .sysooffslong    ��� null
� 
errn��@�  � ������
�� 
errn���@��  ��Y
� 
erob
�  
leng�� 0 
resultlist 
resultList� ������� ��
�� .ascrinit****      � ****� k      ����  ��  ��    ���� 
0 _list_   ���� 
0 _list_  �� jv��� 
0 _list_  �� 0 etext eText� ����
�� 
errn�� 0 enumber eNumber ����
�� 
erob�� 0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �,cN��Fb  ��l+ E�Ob  ��l+ E�O�j
 ���& b  �����+ Y hOb  ��l+ E�O�j  � �jE�O��E�O� �[a \[Zl\Zi2E�Y hO�a  �[a \[Zm\Zi2E�Y hO U�[a a l kh �a  E�Oa  *a �a a � UE�O�j  )a a lhY hO��kE�[OY��W X  )a a a  ��a !O�	 	��k �& )a a a  ��a "Y hO� 	�'E�Y hO�Y�a #,�#j )a a a  ��a $�%a %%Y hOa &a 'K (S�O �k�a #,E�h jE�O |�[a \[Z�\Z��k2[a a l kh �a  E�Oa  *a �a a )� UE�O�j  &)a a a  �[a \[Z�\Z��k2�a *Y hO��kE�[OY��O�	 	��k �& &)a a a  �[a \[Z�\Z��k2�a +Y hO��a ,,6F[OY�<O�a ,,EVW X - .*a /����a 0+ 1� ���������
�� .Mth:DeRanull���     doub�� 0 n  ��   ������������ 0 n  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo �������������
�� 
doub
�� 
pi  �� ��� 0 etext eText ����
�� 
errn�� 0 enumber eNumber ����	
�� 
erob�� 0 efrom eFrom	 ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  ��  ��&��! W X  *塢���+ � �������
��
�� .Mth:RaDenull���     doub�� 0 n  ��  
 ������������ 0 n  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo �����������
�� 
pi  �� ��� 0 etext eText ����
�� 
errn�� 0 enumber eNumber ����
�� 
erob�� 0 efrom eFrom �����
�� 
errt�� 
0 eto eTo�  �� �� 
0 _error  ��  ���!!W X  *䡢���+ � �����
� .Mth:Abs_null���     nmbr� 0 n  �   ������ 0 n  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo ����
� 
nmbr� 0 etext eText ��
� 
errn� 0 enumber eNumber ��
� 
erob� 0 efrom eFrom ���
� 
errt� 
0 eto eTo�  � � 
0 _error  � * ��&E�O�j �'Y �W X  *㡢���+ � �!���
� .Mth:CmpNnull���     ****� ��   ��� 0 n1  � 0 n2  �   	���������� 0 n1  � 0 n2  � 0 dn  � 0 dm  � 0 d  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo ����������
� 
kocl
� 
long
� .corecnte****       ****
� 
doub
� 
cobj
� 
bool� 0 etext eText ��
� 
errn� 0 enumber eNumber ��
� 
erob� 0 efrom eFrom ���
� 
errt� 
0 eto eTo�  � � 
0 _error  � � ���lv��l l  ��  jY hY s��&��&lvE[�k/E�Z[�l/E�ZO�j  b  � E�Y b  � E�O�'E�O�� ��lvE[�k/E�Z[�l/E�ZY hO��E�O��	 ���& jY hO�� iY kW X  *襦���+ 
� �����
� .Mth:MinNnull���     ****� 0 thelist theList�   ��������� 0 thelist theList� 0 	theresult 	theResult� 0 aref aRef� 0 n  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo ��~�}�|�{�z�y�x��w�v�~ "0 aslistparameter asListParameter
�} 
cobj
�| 
nmbr
�{ 
kocl
�z .corecnte****       ****
�y 
pcnt�x 0 etext eText �u�t
�u 
errn�t 0 enumber eNumber �s�r
�s 
erob�r 0 efrom eFrom �q�p�o
�q 
errt�p 
0 eto eTo�o  �w �v 
0 _error  � Z Ib  ��l+ E�O��k/�&E�O )�[��l kh ��,�&E�O�� �E�Y h[OY��O�W X  *餥���+ � �n��m�l �k
�n .Mth:MaxNnull���     ****�m 0 thelist theList�l   �j�i�h�g�f�e�d�c�j 0 thelist theList�i 0 	theresult 	theResult�h 0 aref aRef�g 0 n  �f 0 etext eText�e 0 enumber eNumber�d 0 efrom eFrom�c 
0 eto eTo  	�b�a�`�_�^�]�\!	.�[�Z�b "0 aslistparameter asListParameter
�a 
cobj
�` 
nmbr
�_ 
kocl
�^ .corecnte****       ****
�] 
pcnt�\ 0 etext eText! �Y�X"
�Y 
errn�X 0 enumber eNumber" �W�V#
�W 
erob�V 0 efrom eFrom# �U�T�S
�U 
errt�T 
0 eto eTo�S  �[ �Z 
0 _error  �k Z Ib  ��l+ E�O��k/�&E�O )�[��l kh ��,�&E�O�� �E�Y h[OY��O�W X  *餥���+ � �R	>�Q�P$%�O
�R .Mth:RouNnull���     doub�Q 0 num  �P �N&'
�N 
Plac& {�M�L�K�M 0 decimalplaces decimalPlaces�L  �K  ' �J(�I
�J 
Dire( {�H�G�F�H &0 roundingdirection roundingDirection�G  
�F MRndRNhE�I  $ �E�D�C�B�A�@�?�>�E 0 num  �D 0 decimalplaces decimalPlaces�C &0 roundingdirection roundingDirection�B 0 themultiplier theMultiplier�A 0 etext eText�@ 0 enumber eNumber�? 0 efrom eFrom�> 
0 eto eTo% 	X�=	d�<�;�:	�	�	��9	��8�7�6�5�4�3
��2�1)
��0�/�= "0 asrealparameter asRealParameter�< (0 asintegerparameter asIntegerParameter�; 

�: MRndRNhE
�9 MRndRNhT
�8 MRndRNhF
�7 MRndRN_T
�6 MRndRN_F
�5 MRndRN_U
�4 
bool
�3 MRndRN_D�2 >0 throwinvalidparameterconstant throwInvalidParameterConstant�1 0 etext eText) �.�-*
�. 
errn�- 0 enumber eNumber* �,�++
�, 
erob�+ 0 efrom eFrom+ �*�)�(
�* 
errt�) 
0 eto eTo�(  �0 �/ 
0 _error  �O��b  ��l+ E�Ob  ��l+ E�O�j �$E�O�� � �!E�Y hO��  3��lv�l!k#kv 
�k"E�Y �j ��k"E�Y 	��k"E�Y��  1��lv�k#kv 
�k"E�Y �j ��k"E�Y 	��k"E�Y ֢�  C��lv�k#kv �j �k"kE�Y 	�k"kE�Y �j ��k"E�Y 	��k"E�Y ���  
�k"E�Y ���  �j �k"kE�Y 	�k"kE�Y a��  $�j
 	�k#j �& 
�k"E�Y 	�k"kE�Y 9�a   $�j
 	�k#j �& 
�k"E�Y 	�k"kE�Y b  �a l+ O�j  	�k"Y �j 	��"Y ��!W X  *a ����a + � �'
��&�%,-�$�' 0 _sin  �& �#.�# .  �"�" 0 x  �%  , �!� �����! 0 x  �  0 isneg isNeg� 0 y  � 0 z  � 0 z2  � 0 zz  - ������=��wz}��������������� 
� 
cobj�h
� 
pi  � �� � � 
� 
bool�$��#j  $�j 	�'E�Y hOb  ��#�"k/EY hO��#� �!E�O�jE�O� 	�'E�Y hO���! k"E�O��� k"� E�O�l#k  �kE�O�kE�Y hO��#E�O�m �E�O��E�Y hO��� �� �� E�O�� E�O�k 
 �l �& .��l!�� � �� a � a � a � a  E�Y +��� a � a � a � a � a � a  E�O� 	�'E�Y hO�� ����/0�
� .Mth:Sin_null���     doub� 0 n  �  / �����
�	� 0 n  � 0 x  � 0 etext eText� 0 enumber eNumber�
 0 efrom eFrom�	 
0 eto eTo0 ���1��
� 
nmbr� 0 _sin  � 0 etext eText1 ��2
� 
errn� 0 enumber eNumber2 �� 3
� 
erob�  0 efrom eFrom3 ������
�� 
errt�� 
0 eto eTo��  � � 
0 _error  �  *��&k+ W X  *䢣���+ � ������45��
�� .Mth:Cos_null���     doub�� 0 n  ��  4 ������������ 0 n  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo5 ��������6/����
�� 
nmbr�� Z�� 0 _sin  �� 0 etext eText6 ����7
�� 
errn�� 0 enumber eNumber7 ����8
�� 
erob�� 0 efrom eFrom8 ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� ! *��&�k+ W X  *塢���+ � ��?����9:��
�� .Mth:Tan_null���     doub�� 0 n  ��  9 ������������������������ 0 n  �� 0 x  �� 0 isneg isNeg�� 0 y  �� 0 z  �� 0 z2  �� 0 zz  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo: !������������������l����������������� ����;:����
�� 
nmbr�� �� Z��
�� 
bool
�� 
errn���Y
�� 
erob�� 
�� 
cobj��h
�� 
pi  �� ��� �� �� 0 etext eText; ����<
�� 
errn�� 0 enumber eNumber< ����=
�� 
erob�� 0 efrom eFrom= �����
�� 
errt�� 
0 eto eTo�  �� �� 
0 _error  ��5 ��&E�O��#j  ?�j 	�'E�Y hO�� 
 �� �& )�����Y hOb  ��#�"k/EY hO��#� �!E�O�jE�O� 	�'E�Y hO���!!k"E�O��� k"� E�O�l#k  �kE�O�kE�Y hO��a  �a  �a  E�O�� E�O�a  4��� a � a � a  �a � a � a � a !E�Y �E�O�l 
 	�a  �& 
i�!E�Y hO� 	�'E�Y hO�W X  *a ����a +  � �V��>?�� 	0 _asin  � �@� @  �� 0 n  �  > ������� 0 n  � 0 x  � 0 isneg isNeg� 0 zz  � 0 p  � 0 z  ? ����o|�������������12345�
� 
errn��Y
� 
erob� 
� 
pi  � �� ��jE�O� 	�'E�Y hO�k )�����Y hO�� Xk�E�O�� �� �� �� � ��� �� �� �!E�O���$E�O_ �!�E�O�� a E�O��_ �!E�Y ]�a  �E�Y O�� E�O�a � a � a � a � a � a  �a � a � a � a � a !� �E�O� 	�'E�Y hO�_ a !!� �M��AB�
� .Mth:Sinanull���     doub� 0 n  �  A ������ 0 n  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eToB ���Ca��
� 
nmbr� 	0 _asin  � 0 etext eTextC ��D
� 
errn� 0 enumber eNumberD ��E
� 
erob� 0 efrom eFromE ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �  *��&k+ W X  *䡢���+ � �q��FG�
� .Mth:Cosanull���     doub� 0 n  �  F ������ 0 n  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eToG ����H���� Z
� 
nmbr� 	0 _asin  � 0 etext eTextH ��I
� 
errn� 0 enumber eNumberI ��J
� 
erob� 0 efrom eFromJ ���
� 
errt� 
0 eto eTo�  � � 
0 _error  � ! �*��&k+ W X  *塢���+ � ����KL�~
� .Mth:Tananull���     doub� 0 n  �  K �}�|�{�z�y�x�} 0 n  �| 0 x  �{ 0 etext eText�z 0 enumber eNumber�y 0 efrom eFrom�x 
0 eto eToL �w��v�uM��t�s
�w 
nmbr�v 	0 _asin  �u 0 etext eTextM �r�qN
�r 
errn�q 0 enumber eNumberN �p�oO
�p 
erob�o 0 efrom eFromO �n�m�l
�n 
errt�m 
0 eto eTo�l  �t �s 
0 _error  �~ + ��&E�O*��� k�$!k+ W X  *墣���+ � �k��j�iPQ�h
�k .Mth:Sinhnull���     doub�j 0 n  �i  P �g�f�e�d�c�b�g 0 n  �f 0 x  �e 0 etext eText�d 0 enumber eNumber�c 0 efrom eFrom�b 
0 eto eToQ �a��`R��_�^
�a 
nmbr�` 0 etext eTextR �]�\S
�] 
errn�\ 0 enumber eNumberS �[�ZT
�[ 
erob�Z 0 efrom eFromT �Y�X�W
�Y 
errt�X 
0 eto eTo�W  �_ �^ 
0 _error  �h / ��&E�O�b  �$b  �'$ W X  *䢣���+ � �V�U�TUV�S
�V .Mth:Coshnull���     doub�U 0 n  �T  U �R�Q�P�O�N�M�R 0 n  �Q 0 x  �P 0 etext eText�O 0 enumber eNumber�N 0 efrom eFrom�M 
0 eto eToV �L�KW/�J�I
�L 
nmbr�K 0 etext eTextW �H�GX
�H 
errn�G 0 enumber eNumberX �F�EY
�F 
erob�E 0 efrom eFromY �D�C�B
�D 
errt�C 
0 eto eTo�B  �J �I 
0 _error  �S / ��&E�O�b  �$b  �'$ W X  *䢣���+ � �A?�@�?Z[�>
�A .Mth:Tanhnull���     doub�@ 0 n  �?  Z �=�<�;�:�9�8�= 0 n  �< 0 x  �; 0 etext eText�: 0 enumber eNumber�9 0 efrom eFrom�8 
0 eto eTo[ �7�6\i�5�4
�7 
nmbr�6 0 etext eText\ �3�2]
�3 
errn�2 0 enumber eNumber] �1�0^
�1 
erob�0 0 efrom eFrom^ �/�.�-
�/ 
errt�. 
0 eto eTo�-  �5 �4 
0 _error  �> > -��&E�Ob  �$b  �'$b  �$b  �'$!W X  *㢣���+ � �,��+�*_`�)�, 
0 _frexp  �+ �(a�( a  �'�' 0 m  �*  _ �&�%�$�& 0 m  �% 0 isneg isNeg�$ 0 e  ` ���#
�# 
bool�) o�j  
�jlvY hO�jE�O� 	�'E�Y hOjE�O 3h��	 �k�&�k �l!E�O�kE�Y �l E�O�kE�[OY��O� 	�'E�Y hO��lv� �"��!� bc��" 	0 _logn  �! �d� d  �� 0 x  �   b ����� 0 x  � 0 e  � 0 z  � 0 y  c �������Z[\jkl|�����������
� 
errn��Y� 
0 _frexp  
� 
cobj���
� 
bool�<�j )��l�Y hO*�k+ E[�k/E�Z[�l/E�ZO��
 �l�& j�� �kE�O��E�O� �E�Y �kE�O� �E�O��!E�O�� E�O�� � �� � ��� �� �!E�O�E�O��� ��a  E�Y ��� �kE�Ol� kE�Y �kE�O�� E�O�� a � a � a � a � a � a  �a � a � a � a � a !E�O�j ��� E�Y hO��l!E�O��E�O�j ��a  E�Y hO�� ���ef�
� .Mth:Lognnull���     doub� 0 n  �  e �����
� 0 n  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom�
 
0 eto eTof �	��g1��
�	 
nmbr� 	0 _logn  � 0 etext eTextg ��h
� 
errn� 0 enumber eNumberh ��i
� 
erob� 0 efrom eFromi � ����
�  
errt�� 
0 eto eTo��  � � 
0 _error  �  *��&k+ W X  *䡢���+ � ��A����jk��
�� .Mth:Lo10null���     doub�� 0 n  ��  j ������������ 0 n  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTok 
����UVW��lc����
�� 
nmbr�� 	0 _logn  �� 0 etext eTextl ����m
�� 
errn�� 0 enumber eNumberm ����n
�� 
erob�� 0 efrom eFromn ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� % *��&k+ �!� �!W X  *硢���+ 	� ��s����op��
�� .Mth:Logbnull���     doub�� 0 n  �� ������
�� 
Base�� 0 b  ��  o �������������� 0 n  �� 0 b  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTop ������q�����
�� 
nmbr�� 	0 _logn  �� 0 etext eTextq ����r
�� 
errn�� 0 enumber eNumberr ����s
�� 
erob�� 0 efrom eFroms ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� ( *��&k+ *��&k+ !W X  *䢣���+ ascr  ��ޭ