FasdUAS 1.101.10   ��   ��    k             l      ��  ��   ]W Number -- manipulate numeric values and perform common math functions

Notes:

- The Trigonometry and Logarithm handlers are slightly modified versions of handlers found in ESG MathLib <http://www.esglabs.com/>, which in turn are conversions of functions in the Cephes Mathematical Library by Stephen L. Moshier <http://netlib.org/cephes/>.


TO DO: 

- debug, finalize `parse/format number` behaviors

- should `tan` return `infinity` symbol instead of erroring?

- use identifiers rather than properties in number format record? (other libraries already do this to mimimize namespace pollution)

     � 	 	�   N u m b e r   - -   m a n i p u l a t e   n u m e r i c   v a l u e s   a n d   p e r f o r m   c o m m o n   m a t h   f u n c t i o n s 
 
 N o t e s : 
 
 -   T h e   T r i g o n o m e t r y   a n d   L o g a r i t h m   h a n d l e r s   a r e   s l i g h t l y   m o d i f i e d   v e r s i o n s   o f   h a n d l e r s   f o u n d   i n   E S G   M a t h L i b   < h t t p : / / w w w . e s g l a b s . c o m / > ,   w h i c h   i n   t u r n   a r e   c o n v e r s i o n s   o f   f u n c t i o n s   i n   t h e   C e p h e s   M a t h e m a t i c a l   L i b r a r y   b y   S t e p h e n   L .   M o s h i e r   < h t t p : / / n e t l i b . o r g / c e p h e s / > . 
 
 
 T O   D O :   
 
 -   d e b u g ,   f i n a l i z e   ` p a r s e / f o r m a t   n u m b e r `   b e h a v i o r s 
 
 -   s h o u l d   ` t a n `   r e t u r n   ` i n f i n i t y `   s y m b o l   i n s t e a d   o f   e r r o r i n g ? 
 
 -   u s e   i d e n t i f i e r s   r a t h e r   t h a n   p r o p e r t i e s   i n   n u m b e r   f o r m a t   r e c o r d ?   ( o t h e r   l i b r a r i e s   a l r e a d y   d o   t h i s   t o   m i m i m i z e   n a m e s p a c e   p o l l u t i o n ) 
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
�_� e ; 5 the mathematical constant e (natural logarithm base)    f � i i j   t h e   m a t h e m a t i c a l   c o n s t a n t   e   ( n a t u r a l   l o g a r i t h m   b a s e ) c  j k j l     ��������  ��  ��   k  l m l l      n o p n j   % '�� q�� 0 _isequaldelta _isEqualDelta q m   % & r r =q���-� o i c multiplier used by `cmp` to allow for slight differences due to floating point's limited precision    p � s s �   m u l t i p l i e r   u s e d   b y   ` c m p `   t o   a l l o w   f o r   s l i g h t   d i f f e r e n c e s   d u e   t o   f l o a t i n g   p o i n t ' s   l i m i t e d   p r e c i s i o n m  t u t l     ��������  ��  ��   u  v w v l     ��������  ��  ��   w  x y x l     �� z {��   z J D--------------------------------------------------------------------    { � | | � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - y  } ~ } l     ��  ���      parse and format    � � � � "   p a r s e   a n d   f o r m a t ~  � � � l     ��������  ��  ��   �  � � � i  ( + � � � I      �� ����� (0 _asintegerproperty _asIntegerProperty �  � � � o      ���� 0 thevalue theValue �  � � � o      ���� 0 propertyname propertyName �  ��� � o      ���� 0 minvalue minValue��  ��   � l    8 � � � � Q     8 � � � � k    & � �  � � � r     � � � c     � � � o    ���� 0 thevalue theValue � m    ��
�� 
long � o      ���� 0 n   �  � � � Z  	 # � ����� � G   	  � � � >   	  � � � o   	 
���� 0 n   � c   
  � � � o   
 ���� 0 thevalue theValue � m    ��
�� 
doub � A     � � � o    ���� 0 n   � o    ���� 0 minvalue minValue � R    ���� �
�� .ascrerr ****      � ****��   � �� ���
�� 
errn � m    �����Y��  ��  ��   �  ��� � L   $ & � � o   $ %���� 0 n  ��   � R      ���� �
�� .ascrerr ****      � ****��   � �� ���
�� 
errn � d       � � m      �������   � R   . 8�� � �
�� .ascrerr ****      � **** � b   2 7 � � � b   2 5 � � � m   2 3 � � � � � J  n u m b e r   f o r m a t   d e f i n i t i o n    r e c o r d  s    � o   3 4���� 0 propertyname propertyName � m   5 6 � � � � � P    p r o p e r t y   i s   n o t   a   n o n - n e g a t i v e   i n t e g e r � �� ���
�� 
errn � m   0 1�����Y��   � . ( TO DO: what about sensible upper bound?    � � � � P   T O   D O :   w h a t   a b o u t   s e n s i b l e   u p p e r   b o u n d ? �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � i  , / � � � I      �� ����� ,0 _makenumberformatter _makeNumberFormatter �  � � � o      ���� 0 formatstyle formatStyle �  � � � o      ���� 0 
localecode 
localeCode �  ��� � o      ���� 0 defaultstyle defaultStyle��  ��   � l   � � � � � k    � � �  � � � l     � � � � r      � � � n     � � � I    �������� 0 init  ��  ��   � n     � � � I    �������� 	0 alloc  ��  ��   � n     � � � o    ���� &0 nsnumberformatter NSNumberFormatter � m     ��
�� misccura � o      ���� 0 asocformatter asocFormatter �	 (note that while NSFormatter provides a global +setDefaultFormatterBehavior: option to change all NSNumberFormatters to use pre-10.4 behavior, we don't bother to call setFormatterBehavior: as it's very unlikely nowadays that a host process would change this)    � � � �   ( n o t e   t h a t   w h i l e   N S F o r m a t t e r   p r o v i d e s   a   g l o b a l   + s e t D e f a u l t F o r m a t t e r B e h a v i o r :   o p t i o n   t o   c h a n g e   a l l   N S N u m b e r F o r m a t t e r s   t o   u s e   p r e - 1 0 . 4   b e h a v i o r ,   w e   d o n ' t   b o t h e r   t o   c a l l   s e t F o r m a t t e r B e h a v i o r :   a s   i t ' s   v e r y   u n l i k e l y   n o w a d a y s   t h a t   a   h o s t   p r o c e s s   w o u l d   c h a n g e   t h i s ) �  � � � Q   � � � � � Z   j � �� � � =     � � � l    ��~�} � I   �| � �
�| .corecnte****       **** � J     � �  ��{ � o    �z�z 0 formatstyle formatStyle�{   � �y ��x
�y 
kocl � m    �w
�w 
reco�x  �~  �}   � m    �v�v  � k   N � �  � � � r    P � � � n   N � � � I   $ N�u ��t�u 60 asoptionalrecordparameter asOptionalRecordParameter �  � � � o   $ %�s�s 0 formatstyle formatStyle �  � � � K   % G � � �r � �
�r 
pcls � l  & ' ��q�p � m   & '�o
�o 
MthR�q  �p   � �n � �
�n 
MthA � n  ( / � � � o   - /�m�m 0 requiredvalue RequiredValue � o   ( -�l�l 0 _support   � �k � �
�k 
MthB � m   0 1�j
�j 
msng � �i 
�i 
MthC  m   2 3�h
�h 
msng �g
�g 
MthD m   4 5�f
�f 
msng �e
�e 
MthE m   6 7�d
�d 
msng �c
�c 
MthF m   : ;�b
�b 
msng �a	
�a 
MthG m   > ?�`
�` 
msng	 �_
�^
�_ 
MthH
 m   B C�]
�] 
msng�^   � �\ m   G J � 
 u s i n g�\  �t   � o    $�[�[ 0 _support   � o      �Z�Z 0 formatrecord formatRecord �  I   Q [�Y�X�Y "0 _setbasicformat _setBasicFormat  o   R S�W�W 0 asocformatter asocFormatter  n  S V 1   T V�V
�V 
MthA o   S T�U�U 0 formatrecord formatRecord �T o   V W�S�S 0 defaultstyle defaultStyle�T  �X    Z   \ y�R�Q >  \ a n  \ _ 1   ] _�P
�P 
MthB o   \ ]�O�O 0 formatrecord formatRecord m   _ `�N
�N 
msng n  d u !  I   e u�M"�L�M 60 setminimumfractiondigits_ setMinimumFractionDigits_" #�K# I   e q�J$�I�J (0 _asintegerproperty _asIntegerProperty$ %&% n  f i'(' 1   g i�H
�H 
MthB( o   f g�G�G 0 formatrecord formatRecord& )*) m   i l++ �,, , m i n i m u m   d e c i m a l   p l a c e s* -�F- m   l m�E�E  �F  �I  �K  �L  ! o   d e�D�D 0 asocformatter asocFormatter�R  �Q   ./. Z   z �01�C�B0 >  z 232 n  z }454 1   { }�A
�A 
MthC5 o   z {�@�@ 0 formatrecord formatRecord3 m   } ~�?
�? 
msng1 n  � �676 I   � ��>8�=�> 60 setmaximumfractiondigits_ setMaximumFractionDigits_8 9�<9 I   � ��;:�:�; (0 _asintegerproperty _asIntegerProperty: ;<; n  � �=>= 1   � ��9
�9 
MthC> o   � ��8�8 0 formatrecord formatRecord< ?@? m   � �AA �BB , m a x i m u m   d e c i m a l   p l a c e s@ C�7C m   � ��6�6  �7  �:  �<  �=  7 o   � ��5�5 0 asocformatter asocFormatter�C  �B  / DED Z   � �FG�4�3F >  � �HIH n  � �JKJ 1   � ��2
�2 
MthDK o   � ��1�1 0 formatrecord formatRecordI m   � ��0
�0 
msngG k   � �LL MNM n  � �OPO I   � ��/Q�.�/ <0 setminimumsignificantdigits_ setMinimumSignificantDigits_Q R�-R I   � ��,S�+�, (0 _asintegerproperty _asIntegerPropertyS TUT n  � �VWV 1   � ��*
�* 
MthDW o   � ��)�) 0 formatrecord formatRecordU XYX m   � �ZZ �[[ 4 m i n i m u m   s i g n i f i c a n t   d i g i t sY \�(\ m   � ��'�'  �(  �+  �-  �.  P o   � ��&�& 0 asocformatter asocFormatterN ]�%] n  � �^_^ I   � ��$`�#�$ 60 setusessignificantdigits_ setUsesSignificantDigits_` a�"a m   � ��!
�! boovtrue�"  �#  _ o   � �� �  0 asocformatter asocFormatter�%  �4  �3  E bcb Z   � �de��d >  � �fgf n  � �hih 1   � ��
� 
MthEi o   � ��� 0 formatrecord formatRecordg m   � ��
� 
msnge k   � �jj klk n  � �mnm I   � ��o�� <0 setmaximumsignificantdigits_ setMaximumSignificantDigits_o p�p I   � ��q�� (0 _asintegerproperty _asIntegerPropertyq rsr n  � �tut 1   � ��
� 
MthEu o   � ��� 0 formatrecord formatRecords vwv m   � �xx �yy 4 m a x i m u m   s i g n i f i c a n t   d i g i t sw z�z m   � ���  �  �  �  �  n o   � ��� 0 asocformatter asocFormatterl {�{ n  � �|}| I   � ��~�� 60 setusessignificantdigits_ setUsesSignificantDigits_~ � m   � ��
� boovtrue�  �  } o   � ��� 0 asocformatter asocFormatter�  �  �  c ��� Z   �2���
�	� >  � ���� n  � ���� 1   � ��
� 
MthF� o   � ��� 0 formatrecord formatRecord� m   � ��
� 
msng� Q   �.���� k   ��� ��� r   � ���� c   � ���� n  � ���� 1   � ��
� 
MthF� o   � ��� 0 formatrecord formatRecord� m   � ��
� 
ctxt� o      �� 0 s  � ��� Z  ����� � =   ���� n  � ��� 1   � ��
�� 
leng� o   � ����� 0 s  � m   ����  � R  �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� m  	�����Y��  �  �   � ���� n ��� I  ������� ,0 setdecimalseparator_ setDecimalSeparator_� ���� o  ���� 0 s  ��  ��  � o  ���� 0 asocformatter asocFormatter��  � R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      �������  � R  ".����
�� .ascrerr ****      � ****� m  *-�� ��� �  n u m b e r   f o r m a t   d e f i n i t i o n    r e c o r d  s    d e c i m a l   s e p a r a t o r    p r o p e r t y   i s   n o t   n o n - e m p t y   t e x t� �����
�� 
errn� m  &)�����Y��  �
  �	  � ��� Z  3�������� > 3:��� n 38��� 1  48��
�� 
MthG� o  34���� 0 formatrecord formatRecord� m  89��
�� 
msng� Q  =����� k  @l�� ��� r  @K��� c  @I��� n @E��� 1  AE��
�� 
MthG� o  @A���� 0 formatrecord formatRecord� m  EH��
�� 
ctxt� o      ���� 0 s  � ���� Z  Ll������ =  LS��� n LQ��� 1  MQ��
�� 
leng� o  LM���� 0 s  � m  QR����  � n V\��� I  W\������� 60 setusesgroupingseparator_ setUsesGroupingSeparator_� ���� m  WX��
�� boovfals��  ��  � o  VW���� 0 asocformatter asocFormatter��  � k  _l�� ��� n _e��� I  `e������� 60 setusesgroupingseparator_ setUsesGroupingSeparator_� ���� m  `a��
�� boovtrue��  ��  � o  _`���� 0 asocformatter asocFormatter� ���� n fl��� I  gl������� .0 setgroupingseparator_ setGroupingSeparator_� ���� o  gh���� 0 s  ��  ��  � o  fg���� 0 asocformatter asocFormatter��  ��  � R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      �������  � R  t�����
�� .ascrerr ****      � ****� m  |�� ��� �  n u m b e r   f o r m a t   d e f i n i t i o n    r e c o r d  s    g r o u p i n g   s e p a r a t o r    p r o p e r t y   i s   n o t   t e x t� �����
�� 
errn� m  x{�����Y��  ��  ��  � ���� Z  �N������� > ����� n ����� 1  ����
�� 
MthH� o  ������ 0 formatrecord formatRecord� m  ����
�� 
msng� Z  �J����� = ����� n ����� 1  ����
�� 
MthH� o  ������ 0 formatrecord formatRecord� l �������� m  ����
�� MRndRNhE��  ��  � n ����� I  ��������� $0 setroundingmode_ setRoundingMode_� ���� l �������� n ����� o  ������ @0 nsnumberformatterroundhalfeven NSNumberFormatterRoundHalfEven� m  ����
�� misccura��  ��  ��  ��  � o  ������ 0 asocformatter asocFormatter� ��� = ����� n ����� 1  ����
�� 
MthH� o  ������ 0 formatrecord formatRecord� l �������� m  ����
�� MRndRNhT��  ��  � ��� n ��� � I  �������� $0 setroundingmode_ setRoundingMode_ �� l ������ n �� o  ������ @0 nsnumberformatterroundhalfdown NSNumberFormatterRoundHalfDown m  ����
�� misccura��  ��  ��  ��    o  ������ 0 asocformatter asocFormatter�  = ��	 n ��

 1  ����
�� 
MthH o  ������ 0 formatrecord formatRecord	 l ������ m  ����
�� MRndRNhF��  ��    n �� I  �������� $0 setroundingmode_ setRoundingMode_ �� l ������ n �� o  ������ <0 nsnumberformatterroundhalfup NSNumberFormatterRoundHalfUp m  ����
�� misccura��  ��  ��  ��   o  ������ 0 asocformatter asocFormatter  = �� n �� 1  ����
�� 
MthH o  ������ 0 formatrecord formatRecord l ������ m  ����
�� MRndRN_T��  ��    n ��  I  ����!���� $0 setroundingmode_ setRoundingMode_! "��" l ��#����# n ��$%$ o  ������ 80 nsnumberformatterrounddown NSNumberFormatterRoundDown% m  ����
�� misccura��  ��  ��  ��    o  ������ 0 asocformatter asocFormatter &'& = ��()( n ��*+* 1  ����
�� 
MthH+ o  ������ 0 formatrecord formatRecord) l ��,����, m  ����
�� MRndRN_F��  ��  ' -.- n �	/0/ I   	��1���� $0 setroundingmode_ setRoundingMode_1 2��2 l  3��~3 n  454 o  �}�} 40 nsnumberformatterroundup NSNumberFormatterRoundUp5 m   �|
�| misccura�  �~  ��  ��  0 o  � �{�{ 0 asocformatter asocFormatter. 676 = 898 n :;: 1  �z
�z 
MthH; o  �y�y 0 formatrecord formatRecord9 l <�x�w< m  �v
�v MRndRN_U�x  �w  7 =>= n "?@? I  "�uA�t�u $0 setroundingmode_ setRoundingMode_A B�sB l C�r�qC n DED o  �p�p >0 nsnumberformatterroundceiling NSNumberFormatterRoundCeilingE m  �o
�o misccura�r  �q  �s  �t  @ o  �n�n 0 asocformatter asocFormatter> FGF = %.HIH n %*JKJ 1  &*�m
�m 
MthHK o  %&�l�l 0 formatrecord formatRecordI l *-L�k�jL m  *-�i
�i MRndRN_D�k  �j  G M�hM n 1;NON I  2;�gP�f�g $0 setroundingmode_ setRoundingMode_P Q�eQ l 27R�d�cR n 27STS o  37�b�b :0 nsnumberformatterroundfloor NSNumberFormatterRoundFloorT m  23�a
�a misccura�d  �c  �e  �f  O o  12�`�` 0 asocformatter asocFormatter�h  � R  >J�_UV
�_ .ascrerr ****      � ****U m  FIWW �XX �  n u m b e r   f o r m a t   d e f i n i t i o n    r e c o r d  s    r o u n d i n g   b e h a v i o r    i s   n o t   a n   a l l o w e d   c o n s t a n tV �^Y�]
�^ 
errnY m  BE�\�\�Y�]  ��  ��  ��  �   � Q  QjZ[\Z I  T\�[]�Z�[ "0 _setbasicformat _setBasicFormat] ^_^ o  UV�Y�Y 0 asocformatter asocFormatter_ `a` o  VW�X�X 0 formatstyle formatStylea b�Wb o  WX�V�V 0 defaultstyle defaultStyle�W  �Z  [ R      �U�Tc
�U .ascrerr ****      � ****�T  c �Sd�R
�S 
errnd d      ee m      �Q�Q��R  \ R  dj�Pf�O
�P .ascrerr ****      � ****f m  figg �hh | n o t   a    n u m b e r   f o r m a t   d e f i n i t i o n    r e c o r d   o r   a n   a l l o w e d   c o n s t a n t�O   � R      �Nij
�N .ascrerr ****      � ****i o      �M�M 0 etext eTextj �Lk�K
�L 
errnk d      ll m      �J�J��K   � n r�mnm I  w��Io�H�I .0 throwinvalidparameter throwInvalidParametero pqp o  wx�G�G 0 formatstyle formatStyleq rsr m  x{tt �uu 
 u s i n gs vwv J  {�xx yzy m  {|�F
�F 
recoz {�E{ m  |�D
�D 
enum�E  w |�C| o  ���B�B 0 etext eText�C  �H  n o  rw�A�A 0 _support   � }~} n ��� I  ���@��?�@ 0 
setlocale_ 
setLocale_� ��>� l ����=�<� n ����� I  ���;��:�; *0 asnslocaleparameter asNSLocaleParameter� ��� o  ���9�9 0 
localecode 
localeCode� ��8� m  ���� ���  f o r   l o c a l e�8  �:  � o  ���7�7 0 _support  �=  �<  �>  �?  � o  ���6�6 0 asocformatter asocFormatter~ ��5� L  ���� o  ���4�4 0 asocformatter asocFormatter�5   � o i note: this doesn't handle `default format` option as the appropriate default may vary according to usage    � ��� �   n o t e :   t h i s   d o e s n ' t   h a n d l e   ` d e f a u l t   f o r m a t `   o p t i o n   a s   t h e   a p p r o p r i a t e   d e f a u l t   m a y   v a r y   a c c o r d i n g   t o   u s a g e � ��� l     �3�2�1�3  �2  �1  � ��� l     �0�/�.�0  �/  �.  � ��� i  0 3��� I      �-��,�- "0 _setbasicformat _setBasicFormat� ��� o      �+�+ 0 asocformatter asocFormatter� ��� o      �*�* 0 
formatname 
formatName� ��)� o      �(�( 0 defaultstyle defaultStyle�)  �,  � Z     ������ =    ��� o     �'�' 0 
formatname 
formatName� m    �&
�& MthZMth0� n   ��� I    �%��$�% "0 setnumberstyle_ setNumberStyle_� ��#� o    �"�" 0 defaultstyle defaultStyle�#  �$  � o    �!�! 0 asocformatter asocFormatter� ��� =   ��� o    � �  0 
formatname 
formatName� m    �
� MthZMth3� ��� l   ���� n   ��� I    ���� "0 setnumberstyle_ setNumberStyle_� ��� l   ���� n   ��� o    �� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle� m    �
� misccura�  �  �  �  � o    �� 0 asocformatter asocFormatter�   uses exponent notation   � ��� .   u s e s   e x p o n e n t   n o t a t i o n� ��� =    #��� o     !�� 0 
formatname 
formatName� m   ! "�
� MthZMth1� ��� l  & .���� n  & .��� I   ' .���� "0 setnumberstyle_ setNumberStyle_� ��� l  ' *���� n  ' *��� o   ( *�� 40 nsnumberformatternostyle NSNumberFormatterNoStyle� m   ' (�
� misccura�  �  �  �  � o   & '�� 0 asocformatter asocFormatter� "  uses plain integer notation   � ��� 8   u s e s   p l a i n   i n t e g e r   n o t a t i o n� ��� =  1 4��� o   1 2�� 0 
formatname 
formatName� m   2 3�
� MthZMth2� ��� l  7 ?���� n  7 ?��� I   8 ?�
��	�
 "0 setnumberstyle_ setNumberStyle_� ��� l  8 ;���� n  8 ;��� o   9 ;�� >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyle� m   8 9�
� misccura�  �  �  �	  � o   7 8�� 0 asocformatter asocFormatter� - ' uses thousands separators, no exponent   � ��� N   u s e s   t h o u s a n d s   s e p a r a t o r s ,   n o   e x p o n e n t� ��� =  B E��� o   B C�� 0 
formatname 
formatName� m   C D�
� MthZMth5� ��� l  H P���� n  H P��� I   I P� ����  "0 setnumberstyle_ setNumberStyle_� ���� l  I L������ n  I L��� o   J L���� @0 nsnumberformattercurrencystyle NSNumberFormatterCurrencyStyle� m   I J��
�� misccura��  ��  ��  ��  � o   H I���� 0 asocformatter asocFormatter�   adds currency symbol   � ��� *   a d d s   c u r r e n c y   s y m b o l� ��� =  S V��� o   S T���� 0 
formatname 
formatName� m   T U��
�� MthZMth4� ��� l  Y a���� n  Y a��� I   Z a������� "0 setnumberstyle_ setNumberStyle_� ���� l  Z ]������ n  Z ]��� o   [ ]���� >0 nsnumberformatterpercentstyle NSNumberFormatterPercentStyle� m   Z [��
�� misccura��  ��  ��  ��  � o   Y Z���� 0 asocformatter asocFormatter� ( " multiplies by 100 and appends '%'   � ��� D   m u l t i p l i e s   b y   1 0 0   a n d   a p p e n d s   ' % '� ��� =  d g��� o   d e���� 0 
formatname 
formatName� m   e f��
�� MthZMth6�    l  j r n  j r I   k r������ "0 setnumberstyle_ setNumberStyle_ �� l  k n	����	 n  k n

 o   l n���� @0 nsnumberformatterspelloutstyle NSNumberFormatterSpellOutStyle m   k l��
�� misccura��  ��  ��  ��   o   j k���� 0 asocformatter asocFormatter   uses words    �    u s e s   w o r d s  >   u � l  u ����� I  u ���
�� .corecnte****       **** J   u x �� o   u v���� 0 
formatname 
formatName��   ����
�� 
kocl m   y |��
�� 
ctxt��  ��  ��   m   � �����   �� n  � � I   � ������� 0 
setformat_ 
setFormat_ �� o   � ����� 0 
formatname 
formatName��  ��   o   � ����� 0 asocformatter asocFormatter��  � R   � ���
�� .ascrerr ****      � **** m   � � � p i n v a l i d    b a s i c   f o r m a t    p r o p e r t y :   n o t   a n   a l l o w e d   c o n s t a n t �� !
�� 
errn  m   � ������Y! ��"#
�� 
erob" o   � ����� 0 
formatname 
formatName# ��$��
�� 
errt$ m   � ���
�� 
enum��  � %&% l     ��������  ��  ��  & '(' l     ��������  ��  ��  ( )*) i  4 7+,+ I      ��-����  0 _nameforformat _nameForFormat- .��. o      ���� 0 formatstyle formatStyle��  ��  , l    H/01/ Z     H23452 =    676 o     ���� 0 formatstyle formatStyle7 m    ��
�� MthZMth13 L    88 m    99 �::  i n t e g e r4 ;<; =   =>= o    ���� 0 formatstyle formatStyle> m    ��
�� MthZMth2< ?@? L    AA m    BB �CC  d e c i m a l@ DED =   FGF o    ���� 0 formatstyle formatStyleG m    ��
�� MthZMth5E HIH L    JJ m    KK �LL  c u r r e n c yI MNM =  ! $OPO o   ! "���� 0 formatstyle formatStyleP m   " #��
�� MthZMth4N QRQ L   ' )SS m   ' (TT �UU  p e r c e n tR VWV =  , /XYX o   , -���� 0 formatstyle formatStyleY m   - .��
�� MthZMth3W Z[Z L   2 4\\ m   2 3]] �^^  s c i e n t i f i c[ _`_ =  7 :aba o   7 8���� 0 formatstyle formatStyleb m   8 9��
�� MthZMth6` c��c L   = ?dd m   = >ee �ff  w o r d��  5 L   B Hgg b   B Ghih b   B Ejkj m   B Cll �mm  k o   C D���� 0 formatstyle formatStylei m   E Fnn �oo  0 G A used for error reporting; formatStyle is either constant or text   1 �pp �   u s e d   f o r   e r r o r   r e p o r t i n g ;   f o r m a t S t y l e   i s   e i t h e r   c o n s t a n t   o r   t e x t* qrq l     ��������  ��  ��  r sts l     ��������  ��  ��  t uvu l     ��wx��  w  -----   x �yy 
 - - - - -v z{z l     ��������  ��  ��  { |}| i  8 ;~~ I     ����
�� .Mth:FNumnull���     nmbr� o      ���� 0 	thenumber 	theNumber� ����
�� 
Usin� |����������  ��  � o      ���� 0 formatstyle formatStyle��  � l     ������ m      ��
�� MthZMth0��  ��  � �����
�� 
Loca� |����������  ��  � o      ���� 0 
localecode 
localeCode��  � l     ������ m      ��
�� 
msng��  ��  ��   Q     ����� k    ��� ��� l   "���� Z   "������� =    ��� l   ������ I   ����
�� .corecnte****       ****� J    �� ���� o    ���� 0 	thenumber 	theNumber��  � �����
�� 
kocl� m    ��
�� 
nmbr��  ��  ��  � m    ����  � n   ��� I    ������� 60 throwinvalidparametertype throwInvalidParameterType� ��� o    ���� 0 	thenumber 	theNumber� ��� m    �� ���  � ��� m    ��
�� 
nmbr� ���� m    �� ���  n u m b e r��  ��  � o    ���� 0 _support  ��  ��  � � � only accept integer or real types (i.e. allowing a text parameter to be coerced to number would defeat the purpose of these handlers, which is to avoid unintended localization behavior)   � ���t   o n l y   a c c e p t   i n t e g e r   o r   r e a l   t y p e s   ( i . e .   a l l o w i n g   a   t e x t   p a r a m e t e r   t o   b e   c o e r c e d   t o   n u m b e r   w o u l d   d e f e a t   t h e   p u r p o s e   o f   t h e s e   h a n d l e r s ,   w h i c h   i s   t o   a v o i d   u n i n t e n d e d   l o c a l i z a t i o n   b e h a v i o r )� ��� l  # #������  � � � TO DO: fix this: needs to mimic AS behavior, so use No/Decimal(?) by default and switch to Sci only when number is beyond certain ranges (currently reals always display as sci)   � ���b   T O   D O :   f i x   t h i s :   n e e d s   t o   m i m i c   A S   b e h a v i o r ,   s o   u s e   N o / D e c i m a l ( ? )   b y   d e f a u l t   a n d   s w i t c h   t o   S c i   o n l y   w h e n   n u m b e r   i s   b e y o n d   c e r t a i n   r a n g e s   ( c u r r e n t l y   r e a l s   a l w a y s   d i s p l a y   a s   s c i )� ��� Z   # ������� F   # .��� =  # &��� o   # $���� 0 formatstyle formatStyle� m   $ %��
�� MthZMth0� =  ) ,��� o   ) *���� 0 
localecode 
localeCode� m   * +��
�� 
msng� k   1 o�� ��� r   1 >��� n  1 <��� I   8 <������� 0 init  ��  �  � n  1 8��� I   4 8�~�}�|�~ 	0 alloc  �}  �|  � n  1 4��� o   2 4�{�{ &0 nsnumberformatter NSNumberFormatter� m   1 2�z
�z misccura� o      �y�y 0 asocformatter asocFormatter� ��� n  ? K��� I   @ K�x��w�x 0 
setlocale_ 
setLocale_� ��v� l  @ G��u�t� n  @ G��� I   C G�s�r�q�s 0 systemlocale systemLocale�r  �q  � n  @ C��� o   A C�p�p 0 nslocale NSLocale� m   @ A�o
�o misccura�u  �t  �v  �w  � o   ? @�n�n 0 asocformatter asocFormatter� ��m� Z   L o���l�� =  L U��� n  L Q��� m   M Q�k
�k 
pcls� o   L M�j�j 0 	thenumber 	theNumber� m   Q T�i
�i 
long� n  X b��� I   Y b�h��g�h "0 setnumberstyle_ setNumberStyle_� ��f� l  Y ^��e�d� n  Y ^��� o   Z ^�c�c 40 nsnumberformatternostyle NSNumberFormatterNoStyle� m   Y Z�b
�b misccura�e  �d  �f  �g  � o   X Y�a�a 0 asocformatter asocFormatter�l  � n  e o��� I   f o�`��_�` "0 setnumberstyle_ setNumberStyle_� ��^� l  f k��]�\� n  f k��� o   g k�[�[ D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle� m   f g�Z
�Z misccura�]  �\  �^  �_  � o   e f�Y�Y 0 asocformatter asocFormatter�m  ��  � k   r ��� ��� r   r y��� n  r w��� o   s w�X�X D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle� m   r s�W
�W misccura� o      �V�V 0 defaultstyle defaultStyle� ��U� r   z ���� I   z ��T��S�T ,0 _makenumberformatter _makeNumberFormatter� ��� o   { |�R�R 0 formatstyle formatStyle� ��� o   | }�Q�Q 0 
localecode 
localeCode� ��P� o   } ~�O�O 0 defaultformat defaultFormat�P  �S  � o      �N�N 0 asocformatter asocFormatter�U  � ��� r   � ���� n  � ���� I   � ��M��L�M &0 stringfromnumber_ stringFromNumber_�  �K  o   � ��J�J 0 	thenumber 	theNumber�K  �L  � o   � ��I�I 0 asocformatter asocFormatter� o      �H�H 0 
asocstring 
asocString�  l  � � Z  � ��G�F =  � �	 o   � ��E�E 0 
asocstring 
asocString	 m   � ��D
�D 
msng R   � ��C

�C .ascrerr ****      � ****
 m   � � � F I n v a l i d   n u m b e r   ( c o n v e r s i o n   f a i l e d ) . �B
�B 
errn m   � ��A�A�Y �@�?
�@ 
erob o   � ��>�> 0 	thenumber 	theNumber�?  �G  �F   n h shouldn't fail, but -stringFromNumber:'s return type isn't declared as non-nullable so check to be sure    � �   s h o u l d n ' t   f a i l ,   b u t   - s t r i n g F r o m N u m b e r : ' s   r e t u r n   t y p e   i s n ' t   d e c l a r e d   a s   n o n - n u l l a b l e   s o   c h e c k   t o   b e   s u r e �= L   � � c   � � o   � ��<�< 0 
asocstring 
asocString m   � ��;
�; 
ctxt�=  � R      �:
�: .ascrerr ****      � **** o      �9�9 0 etext eText �8
�8 
errn o      �7�7 0 enumber eNumber �6
�6 
erob o      �5�5 0 efrom eFrom �4�3
�4 
errt o      �2�2 
0 eto eTo�3  � I   � ��1�0�1 
0 _error    m   � �   �!!  f o r m a t   n u m b e r "#" o   � ��/�/ 0 etext eText# $%$ o   � ��.�. 0 enumber eNumber% &'& o   � ��-�- 0 efrom eFrom' (�,( o   � ��+�+ 
0 eto eTo�,  �0  } )*) l     �*�)�(�*  �)  �(  * +,+ l     �'�&�%�'  �&  �%  , -.- i  < ?/0/ I     �$12
�$ .Mth:PNumnull���     ctxt1 o      �#�# 0 thetext theText2 �"34
�" 
Usin3 |�!� 5�6�!  �   5 o      �� 0 formatstyle formatStyle�  6 l     7��7 m      �
� MthZMth0�  �  4 �8�
� 
Loca8 |��9�:�  �  9 o      �� 0 
localecode 
localeCode�  : l     ;��; m      �
� 
msng�  �  �  0 Q     �<=>< k    �?? @A@ l   "BCDB Z   "EF��E =    GHG l   I��I I   �JK
� .corecnte****       ****J J    LL M�M o    �� 0 thetext theText�  K �
N�	
�
 
koclN m    �
� 
ctxt�	  �  �  H m    ��  F n   OPO I    �Q�� 60 throwinvalidparametertype throwInvalidParameterTypeQ RSR o    �� 0 thetext theTextS TUT m    VV �WW  U XYX m    �
� 
ctxtY Z�Z m    [[ �\\  t e x t�  �  P o    �� 0 _support  �  �  C 1 + only accept text, for same reason as above   D �]] V   o n l y   a c c e p t   t e x t ,   f o r   s a m e   r e a s o n   a s   a b o v eA ^_^ Z   # c`a� b` F   # .cdc =  # &efe o   # $���� 0 formatstyle formatStylef m   $ %��
�� MthZMth0d =  ) ,ghg o   ) *���� 0 
localecode 
localeCodeh m   * +��
�� 
msnga k   1 Vii jkj r   1 >lml n  1 <non I   8 <�������� 0 init  ��  ��  o n  1 8pqp I   4 8�������� 	0 alloc  ��  ��  q n  1 4rsr o   2 4���� &0 nsnumberformatter NSNumberFormatters m   1 2��
�� misccuram o      ���� 0 asocformatter asocFormatterk tut n  ? Kvwv I   @ K��x���� 0 
setlocale_ 
setLocale_x y��y l  @ Gz����z n  @ G{|{ I   C G�������� 0 systemlocale systemLocale��  ��  | n  @ C}~} o   A C���� 0 nslocale NSLocale~ m   @ A��
�� misccura��  ��  ��  ��  w o   ? @���� 0 asocformatter asocFormatteru �� n  L V��� I   M V������� "0 setnumberstyle_ setNumberStyle_� ���� l  M R������ n  M R��� o   N R���� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle� m   M N��
�� misccura��  ��  ��  ��  � o   L M���� 0 asocformatter asocFormatter��  �   b r   Y c��� I   Y a������� ,0 _makenumberformatter _makeNumberFormatter� ��� o   Z [���� 0 formatstyle formatStyle� ��� o   [ \���� 0 
localecode 
localeCode� ���� m   \ ]��
�� boovfals��  ��  � o      ���� 0 asocformatter asocFormatter_ ��� r   d l��� n  d j��� I   e j������� &0 numberfromstring_ numberFromString_� ���� o   e f���� 0 thetext theText��  ��  � o   d e���� 0 asocformatter asocFormatter� o      ���� 0 
asocnumber 
asocNumber� ��� Z   m �������� =  m p��� o   m n���� 0 
asocnumber 
asocNumber� m   n o��
�� 
msng� k   s ��� ��� r   s ���� c   s ~��� n  s |��� I   x |�������� $0 localeidentifier localeIdentifier��  ��  � n  s x��� I   t x�������� 
0 locale  ��  ��  � o   s t���� 0 asocformatter asocFormatter� m   | }��
�� 
ctxt� o      ���� $0 localeidentifier localeIdentifier� ��� Z   � ������� =   � ���� n  � ���� 1   � ���
�� 
leng� o   � ����� $0 localeidentifier localeIdentifier� m   � �����  � l  � ����� r   � ���� m   � ��� ���  n o� o      ���� $0 localeidentifier localeIdentifier� #  empty string = system locale   � ��� :   e m p t y   s t r i n g   =   s y s t e m   l o c a l e��  � r   � ���� b   � ���� b   � ���� m   � ��� ��� 
 t h e   � o   � ����� $0 localeidentifier localeIdentifier� m   � ��� ���  � o      ���� $0 localeidentifier localeIdentifier� ���� R   � �����
�� .ascrerr ****      � ****� l  � ������� b   � ���� b   � ���� b   � ���� b   � ���� m   � ��� ��� R I n v a l i d   t e x t   ( e x p e c t e d   n u m e r i c a l   t e x t   i n  � I   � ��������  0 _nameforformat _nameForFormat� ���� o   � ����� 0 formatstyle formatStyle��  ��  � m   � ��� ���    f o r m a t   f o r  � o   � ����� $0 localeidentifier localeIdentifier� m   � ��� ���    l o c a l e ) .��  ��  � ����
�� 
errn� m   � ������Y� �����
�� 
erob� o   � ����� 0 thetext theText��  ��  ��  ��  � ���� L   � ��� c   � ���� o   � ����� 0 
asocnumber 
asocNumber� m   � ���
�� 
****��  = R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  > I   � �������� 
0 _error  � ��� m   � ��� ���  p a r s e   n u m b e r� ��� o   � ����� 0 etext eText� ��� o   � ����� 0 enumber eNumber� ��� o   � ����� 0 efrom eFrom� ���� o   � ����� 
0 eto eTo��  ��  . ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  � $  Hexadecimal number conversion   � ��� <   H e x a d e c i m a l   n u m b e r   c o n v e r s i o n� � � l     ��������  ��  ��     i  @ C I     ��
�� .Mth:NuHenull���     **** o      ���� 0 	thenumber 	theNumber ��
�� 
Plac |����	��
��  ��  	 o      ���� 0 	chunksize 	chunkSize��  
 l     ���� m      ����  ��  ��   ����
�� 
Pref |��������  ��   o      ���� 0 	hasprefix 	hasPrefix��   l     ���� m      �
� boovfals��  ��  ��   Q    � k   �  r     n    I    �~�}�~ (0 asintegerparameter asIntegerParameter  o    	�|�| 0 	chunksize 	chunkSize �{ m   	 
 � 
 w i d t h�{  �}   o    �z�z 0 _support   o      �y�y 0 	chunksize 	chunkSize  !  l   "#$" r    %&% n   '(' I    �x)�w�x (0 asbooleanparameter asBooleanParameter) *+* o    �v�v 0 	hasprefix 	hasPrefix+ ,�u, m    -- �..  p r e f i x�u  �w  ( o    �t�t 0 _support  & o      �s�s 0 	hasprefix 	hasPrefix# � � (users shouldn't concatenate their own prefix as that would result in negative numbers appearing as "0x-N�" instead of "-0xN�")   $ �//    ( u s e r s   s h o u l d n ' t   c o n c a t e n a t e   t h e i r   o w n   p r e f i x   a s   t h a t   w o u l d   r e s u l t   i n   n e g a t i v e   n u m b e r s   a p p e a r i n g   a s   " 0 x - N & "   i n s t e a d   o f   " - 0 x N & " )! 0�r0 Z   �12�q31 =    *454 l   (6�p�o6 I   (�n78
�n .corecnte****       ****7 J    "99 :�m: o     �l�l 0 	thenumber 	theNumber�m  8 �k;�j
�k 
kocl; m   # $�i
�i 
list�j  �p  �o  5 m   ( )�h�h  2 l  -E<=>< k   -E?? @A@ l  - :BCDB r   - :EFE n  - 8GHG I   2 8�gI�f�g 00 aswholenumberparameter asWholeNumberParameterI JKJ o   2 3�e�e 0 	thenumber 	theNumberK L�dL m   3 4MM �NN  �d  �f  H o   - 2�c�c 0 _support  F o      �b�b 0 	thenumber 	theNumberC ^ X numbers greater than 2^30 (max integer size) are okay as long as they're non-fractional   D �OO �   n u m b e r s   g r e a t e r   t h a n   2 ^ 3 0   ( m a x   i n t e g e r   s i z e )   a r e   o k a y   a s   l o n g   a s   t h e y ' r e   n o n - f r a c t i o n a lA PQP l  ; ;�aRS�a  R � � note that the 1024 max chunk size is somewhat arbitrary (the largest representable number requires ~309 chars; anything more will always be left-hand padding), but prevents completely silly values   S �TT�   n o t e   t h a t   t h e   1 0 2 4   m a x   c h u n k   s i z e   i s   s o m e w h a t   a r b i t r a r y   ( t h e   l a r g e s t   r e p r e s e n t a b l e   n u m b e r   r e q u i r e s   ~ 3 0 9   c h a r s ;   a n y t h i n g   m o r e   w i l l   a l w a y s   b e   l e f t - h a n d   p a d d i n g ) ,   b u t   p r e v e n t s   c o m p l e t e l y   s i l l y   v a l u e sQ UVU Z  ; ZWX�`�_W G   ; FYZY A   ; >[\[ o   ; <�^�^ 0 	chunksize 	chunkSize\ m   < =�]�]  Z ?   A D]^] o   A B�\�\ 0 	chunksize 	chunkSize^ m   B C�[�[ X n  I V_`_ I   N V�Za�Y�Z .0 throwinvalidparameter throwInvalidParametera bcb o   N O�X�X 0 	chunksize 	chunkSizec ded m   O Pff �gg 
 w i d t he hih m   P Q�W
�W 
longi j�Vj m   Q Rkk �ll  m u s t   b e   0  1 0 2 4�V  �Y  ` o   I N�U�U 0 _support  �`  �_  V mnm r   [ `opo m   [ ^qq �rr  p o      �T�T 0 hextext hexTextn sts Z   a �uv�Swu A   a dxyx o   a b�R�R 0 	thenumber 	theNumbery m   b c�Q�Q  v k   g �zz {|{ Z  g �}~�P�O} F   g v� ?   g j��� o   g h�N�N 0 	chunksize 	chunkSize� m   h i�M�M  � l  m t��L�K� A   m t��� o   m n�J�J 0 	thenumber 	theNumber� a   n s��� m   n q�I�I��� o   q r�H�H 0 	chunksize 	chunkSize�L  �K  ~ n  y ���� I   ~ ��G��F�G .0 throwinvalidparameter throwInvalidParameter� ��� o   ~ �E�E 0 	thenumber 	theNumber� ��� m    ��� ���  � ��� m   � ��D
�D 
long� ��C� b   � ���� b   � ���� b   � ���� m   � ��� ��� X s p e c i f i e d   w i d t h   o n l y   a l l o w s   n u m b e r s   b e t w e e n  � l  � ���B�A� a   � ���� m   � ��@�@��� o   � ��?�? 0 	chunksize 	chunkSize�B  �A  � m   � ��� ��� 
   a n d  � l  � ���>�=� \   � ���� a   � ���� m   � ��<�< � o   � ��;�; 0 	chunksize 	chunkSize� m   � ��:�: �>  �=  �C  �F  � o   y ~�9�9 0 _support  �P  �O  | ��� r   � ���� m   � ��� ���  -� o      �8�8 0 	hexprefix 	hexPrefix� ��7� r   � ���� d   � ��� o   � ��6�6 0 	thenumber 	theNumber� o      �5�5 0 	thenumber 	theNumber�7  �S  w k   � ��� ��� r   � ���� m   � ��� ���  � o      �4�4 0 	hexprefix 	hexPrefix� ��3� Z  � ����2�1� F   � ���� ?   � ���� o   � ��0�0 0 	chunksize 	chunkSize� m   � ��/�/  � l  � ���.�-� ?   � ���� o   � ��,�, 0 	thenumber 	theNumber� \   � ���� a   � ���� m   � ��+�+ � o   � ��*�* 0 	chunksize 	chunkSize� m   � ��)�) �.  �-  � n  � ���� I   � ��(��'�( .0 throwinvalidparameter throwInvalidParameter� ��� o   � ��&�& 0 	thenumber 	theNumber� ��� m   � ��� ���  � ��� m   � ��%
�% 
long� ��$� b   � ���� b   � ���� b   � ���� m   � ��� ��� X s p e c i f i e d   w i d t h   o n l y   a l l o w s   n u m b e r s   b e t w e e n  � l  � ���#�"� a   � ���� m   � ��!�!��� o   � �� �  0 	chunksize 	chunkSize�#  �"  � m   � ��� ��� 
   a n d  � l  � ����� \   � ���� a   � ���� m   � ��� � o   � ��� 0 	chunksize 	chunkSize� m   � ��� �  �  �$  �'  � o   � ��� 0 _support  �2  �1  �3  t ��� Z  � ������ o   � ��� 0 	hasprefix 	hasPrefix� r   � ���� b   � ���� o   � ��� 0 	hexprefix 	hexPrefix� m   � ��� ���  0 x� o      �� 0 	hexprefix 	hexPrefix�  �  � ��� V   '��� k  "�� ��� r  ��� b  ��� l ���� n  ��� 4  ��
� 
cobj� l ���� [  ��� `  � � o  �� 0 	thenumber 	theNumber  m  �� � m  �� �  �  � m   �   0 1 2 3 4 5 6 7 8 9 A B C D E F�  �  � o  �� 0 hextext hexText� o      �� 0 hextext hexText� �
 r  " _    o  �	�	 0 	thenumber 	theNumber m  ��  o      �� 0 	thenumber 	theNumber�
  � ?  	 o  �� 0 	thenumber 	theNumber	 m  ��  � 

 V  (@ r  4; b  49 m  47 �  0 o  78�� 0 hextext hexText o      �� 0 hextext hexText A  ,3 n  ,1 1  -1�
� 
leng o  ,-�� 0 hextext hexText o  12� �  0 	chunksize 	chunkSize �� L  AE b  AD o  AB���� 0 	hexprefix 	hexPrefix o  BC���� 0 hextext hexText��  =   format single number   > � *   f o r m a t   s i n g l e   n u m b e r�q  3 l H� k  H�   !"! l Hk#$%# Z Hk&'����& G  HS()( A  HK*+* o  HI���� 0 	chunksize 	chunkSize+ m  IJ���� ) ?  NQ,-, o  NO���� 0 	chunksize 	chunkSize- m  OP���� ' n Vg./. I  [g��0���� .0 throwinvalidparameter throwInvalidParameter0 121 o  [\���� 0 	chunksize 	chunkSize2 343 m  \_55 �66 
 w i d t h4 787 m  _`��
�� 
long8 9��9 m  `c:: �;;  m u s t   b e   1  1 0 2 4��  ��  / o  V[���� 0 _support  ��  ��  $   chunksize must be given   % �<< 0   c h u n k s i z e   m u s t   b e   g i v e n" =>= r  l�?@? J  lxAA BCB m  loDD �EE  C F��F \  ovGHG a  otIJI m  or���� J o  rs���� 0 	chunksize 	chunkSizeH m  tu���� ��  @ J      KK LML o      ���� 0 padtext padTextM N��N o      ���� 0 maxsize maxSize��  > OPO U  ��QRQ r  ��STS b  ��UVU o  ������ 0 padtext padTextV m  ��WW �XX  0T o      ���� 0 padtext padTextR o  ������ 0 	chunksize 	chunkSizeP YZY h  ����[�� 0 
resultlist 
resultList[ j     	��\�� 
0 _list_  \ n    ]^] 2   ��
�� 
cobj^ o     ���� 0 	thenumber 	theNumberZ _`_ X  ��a��ba k  �{cc ded Q  �6fghf k  ��ii jkj r  ��lml c  ��non n ��pqp 1  ����
�� 
pcntq o  ������ 0 aref aRefo m  ����
�� 
longm o      ���� 0 	thenumber 	theNumberk r��r Z ��st����s G  ��uvu G  ��wxw >  ��yzy o  ������ 0 	thenumber 	theNumberz c  ��{|{ n ��}~} 1  ����
�� 
pcnt~ o  ������ 0 aref aRef| m  ����
�� 
doubx A  ��� o  ������ 0 	thenumber 	theNumber� m  ������  v ?  ����� o  ������ 0 	thenumber 	theNumber� o  ������ 0 maxsize maxSizet R  �������
�� .ascrerr ****      � ****��  � �����
�� 
errn� m  �������\��  ��  ��  ��  g R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      �������  h Z  6������ ?  ��� o  ���� 0 	thenumber 	theNumber� o  ���� 0 maxsize maxSize� n 	"��� I  "������� .0 throwinvalidparameter throwInvalidParameter� ��� o  ���� 0 	thenumber 	theNumber� ��� m  �� ���  � ��� m  ��
�� 
long� ���� b  ��� m  �� ��� h s p e c i f i e d   w i d t h   o n l y   a l l o w s   n u m b e r s   b e t w e e n   0 . 0   a n d  � l ������ \  ��� a  ��� m  ���� � o  ���� 0 	chunksize 	chunkSize� m  ���� ��  ��  ��  ��  � o  	���� 0 _support  ��  � n %6��� I  *6������� .0 throwinvalidparameter throwInvalidParameter� ��� o  *+���� 0 aref aRef� ��� m  +.�� ���  � ��� m  ./��
�� 
long� ���� m  /2�� ��� V e x p e c t e d   n o n - n e g a t i v e   n o n - f r a c t i o n a l   n u m b e r��  ��  � o  %*���� 0 _support  e ��� r  7<��� m  7:�� ���  � o      ���� 0 hextext hexText� ��� V  =d��� k  E_�� ��� r  EW��� b  EU��� l ES������ n  ES��� 4  HS���
�� 
cobj� l KR������ [  KR��� `  KP��� o  KL���� 0 	thenumber 	theNumber� m  LO���� � m  PQ���� ��  ��  � m  EH�� ���   0 1 2 3 4 5 6 7 8 9 A B C D E F��  ��  � o  ST���� 0 hextext hexText� o      ���� 0 hextext hexText� ���� r  X_��� _  X]��� o  XY���� 0 	thenumber 	theNumber� m  Y\���� � o      ���� 0 	thenumber 	theNumber��  � ?  AD��� o  AB���� 0 	thenumber 	theNumber� m  BC����  � ���� r  e{��� n eu��� 7 hu����
�� 
ctxt� d  nq�� o  op���� 0 	chunksize 	chunkSize� m  rt������� l eh������ b  eh��� o  ef���� 0 padtext padText� o  fg���� 0 hextext hexText��  ��  � n     ��� 1  vz��
�� 
pcnt� o  uv���� 0 aref aRef��  �� 0 aref aRefb n ����� o  ������ 
0 _list_  � o  ������ 0 
resultlist 
resultList` ��� r  ����� n ����� 1  ����
�� 
txdl� 1  ����
�� 
ascr� o      ���� 0 oldtids oldTIDs� ��� r  ����� m  ���� ���  � n     ��� 1  ����
�� 
txdl� 1  ����
�� 
ascr� ��� Z  �������� o  ������ 0 	hasprefix 	hasPrefix� r  ����� b  ����� m  ���� ���  0 x� n ����� o  ������ 
0 _list_  � o  ������ 0 
resultlist 
resultList� o      ���� 0 hextext hexText��  � r  ����� c  ��� � n �� o  ������ 
0 _list_   o  ������ 0 
resultlist 
resultList  m  ����
�� 
ctxt� o      ���� 0 hextext hexText�  r  �� o  ������ 0 oldtids oldTIDs n      1  ����
�� 
txdl 1  ����
�� 
ascr 	��	 L  ��

 o  ������ 0 hextext hexText��     format list of number    � ,   f o r m a t   l i s t   o f   n u m b e r�r   R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��
�� 
errn o      ���� 0 enumber eNumber ��
�� 
erob o      �� 0 efrom eFrom �~�}
�~ 
errt o      �|�| 
0 eto eTo�}   I  ���{�z�{ 
0 _error    m  �� �  f o r m a t   h e x  o  ���y�y 0 etext eText  o  ���x�x 0 enumber eNumber  o  ���w�w 0 efrom eFrom �v o  ���u�u 
0 eto eTo�v  �z     l     �t�s�r�t  �s  �r    !"! l     �q�p�o�q  �p  �o  " #$# i  D G%&% I     �n'(
�n .Mth:HeNunull���     ctxt' o      �m�m 0 hextext hexText( �l)*
�l 
Plac) |�k�j+�i,�k  �j  + o      �h�h 0 	chunksize 	chunkSize�i  , l     -�g�f- m      �e�e  �g  �f  * �d.�c
�d 
Prec. |�b�a/�`0�b  �a  / o      �_�_ 0 	isprecise 	isPrecise�`  0 l     1�^�]1 m      �\
�\ boovtrue�^  �]  �c  & Q    b2342 P   L5675 k   K88 9:9 r    ;<; n   =>= I    �[?�Z�[ "0 astextparameter asTextParameter? @A@ o    �Y�Y 0 hextext hexTextA B�XB m    CC �DD  �X  �Z  > o    �W�W 0 _support  < o      �V�V 0 hextext hexText: EFE r    #GHG n   !IJI I    !�UK�T�U (0 asintegerparameter asIntegerParameterK LML o    �S�S 0 	chunksize 	chunkSizeM N�RN m    OO �PP 
 w i d t h�R  �T  J o    �Q�Q 0 _support  H o      �P�P 0 	chunksize 	chunkSizeF QRQ Z  $ CST�O�NS G   $ /UVU A   $ 'WXW o   $ %�M�M 0 	chunksize 	chunkSizeX m   % &�L�L  V ?   * -YZY o   * +�K�K 0 	chunksize 	chunkSizeZ m   + ,�J�J T n  2 ?[\[ I   7 ?�I]�H�I .0 throwinvalidparameter throwInvalidParameter] ^_^ o   7 8�G�G 0 	chunksize 	chunkSize_ `a` m   8 9bb �cc 
 w i d t ha ded m   9 :�F
�F 
longe f�Ef m   : ;gg �hh  m u s t   b e   0  1 0 2 4�E  �H  \ o   2 7�D�D 0 _support  �O  �N  R iji r   D Rklk H   D Pmm n  D Onon I   I O�Cp�B�C (0 asbooleanparameter asBooleanParameterp qrq o   I J�A�A 0 	isprecise 	isPreciser s�@s m   J Ktt �uu  p r e c i s i o n   l o s s�@  �B  o o   D I�?�? 0 _support  l o      �>�> 0 	isprecise 	isPrecisej v�=v Z   SKwx�<yw =   S Vz{z o   S T�;�; 0 	chunksize 	chunkSize{ m   T U�:�:  x l  Y;|}~| k   Y; ��� Q   Y���� k   \ ��� ��� r   \ _��� m   \ ]�9�9  � o      �8�8 0 	thenumber 	theNumber� ��� r   ` e��� C   ` c��� o   ` a�7�7 0 hextext hexText� m   a b�� ���  -� o      �6�6 0 
isnegative 
isNegative� ��� Z  f }���5�4� o   f g�3�3 0 
isnegative 
isNegative� r   j y��� n   j w��� 7  k w�2��
�2 
ctxt� m   q s�1�1 � m   t v�0�0��� o   j k�/�/ 0 hextext hexText� o      �.�. 0 hextext hexText�5  �4  � ��� Z  ~ ����-�,� C   ~ ���� o   ~ �+�+ 0 hextext hexText� m    ��� ���  0 x� r   � ���� n   � ���� 7  � ��*��
�* 
ctxt� m   � ��)�) � m   � ��(�(��� o   � ��'�' 0 hextext hexText� o      �&�& 0 hextext hexText�-  �,  � ��%� X   � ���$�� k   � ��� ��� r   � ���� ]   � ���� o   � ��#�# 0 	thenumber 	theNumber� m   � ��"�" � o      �!�! 0 	thenumber 	theNumber� ��� r   � ���� I  � ��� �� z��
� .sysooffslong    ��� null
� misccura�   � ���
� 
psof� o   � ��� 0 charref charRef� ���
� 
psin� m   � ��� ���   0 1 2 3 4 5 6 7 8 9 A B C D E F�  � o      �� 0 i  � ��� Z  � ������ =   � ���� o   � ��� 0 i  � m   � ���  � R   � ����
� .ascrerr ****      � ****�  � ���
� 
errn� m   � ����@�  �  �  � ��� r   � ���� \   � ���� [   � ���� o   � ��� 0 	thenumber 	theNumber� o   � ��� 0 i  � m   � ��� � o      �� 0 	thenumber 	theNumber�  �$ 0 charref charRef� o   � ��
�
 0 hextext hexText�%  � R      �	��
�	 .ascrerr ****      � ****�  � ���
� 
errn� d      �� m      ����  � l  ����� R   ����
� .ascrerr ****      � ****� m  �� ��� > N o t   a   v a l i d   h e x a d e c i m a l   n u m b e r .� ���
� 
errn� m   � ����Y� ��� 
� 
erob� o  ���� 0 hextext hexText�   � E ? catch errors if hexText is too short or contains non-hex chars   � ��� ~   c a t c h   e r r o r s   i f   h e x T e x t   i s   t o o   s h o r t   o r   c o n t a i n s   n o n - h e x   c h a r s� ��� Z 	+������� F  	��� o  	
���� 0 	isprecise 	isPrecise� l ������ =  ��� o  ���� 0 	thenumber 	theNumber� [  ��� o  ���� 0 	thenumber 	theNumber� m  ���� ��  ��  � R  '����
�� .ascrerr ****      � ****� m  #&�� ��� � H e x a d e c i m a l   t e x t   i s   t o o   l a r g e   t o   c o n v e r t   t o   n u m b e r   w i t h o u t   l o s i n g   p r e c i s i o n .� ����
�� 
errn� m  �����Y� �����
�� 
erob� o  !"���� 0 hextext hexText��  ��  ��  � ��� Z ,8������� o  ,-���� 0 
isnegative 
isNegative� r  04��� d  02�� o  01���� 0 	thenumber 	theNumber� o      ���� 0 	thenumber 	theNumber��  ��  � ���� L  9;�� o  9:���� 0 	thenumber 	theNumber��  }   read as single number   ~ ��� ,   r e a d   a s   s i n g l e   n u m b e r�<  y l >K���� k  >K�� ��� Z >d������� >  >G   `  >E l >C���� n >C 1  ?C��
�� 
leng o  >?���� 0 hextext hexText��  ��   o  CD���� 0 	chunksize 	chunkSize m  EF����  � R  J`��
�� .ascrerr ****      � **** b  V_	
	 b  V[ m  VY � T C a n ' t   s p l i t   h e x a d e c i m a l   t e x t   e x a c t l y   i n t o   o  YZ���� 0 	chunksize 	chunkSize
 m  [^ �  - d i g i t   c h u n k s . ��
�� 
errn m  NQ�����Y ����
�� 
erob o  TU���� 0 hextext hexText��  ��  ��  �  h  ep���� 0 
resultlist 
resultList j     ���� 
0 _list_   J     ����    Y  qC�� k  �>   r  ��!"! m  ������  " o      ���� 0 	thenumber 	theNumber  #$# X  �%��&% k  ��'' ()( r  ��*+* ]  ��,-, o  ������ 0 	thenumber 	theNumber- m  ������ + o      ���� 0 	thenumber 	theNumber) ./. r  ��010 I ��2��32 z����
�� .sysooffslong    ��� null
�� misccura��  3 ��45
�� 
psof4 o  ������ 0 charref charRef5 ��6��
�� 
psin6 m  ��77 �88   0 1 2 3 4 5 6 7 8 9 A B C D E F��  1 o      ���� 0 i  / 9:9 Z ��;<����; =  ��=>= o  ������ 0 i  > m  ������  < R  ����?@
�� .ascrerr ****      � ****? m  ��AA �BB > N o t   a   v a l i d   h e x a d e c i m a l   n u m b e r .@ ��CD
�� 
errnC m  �������YD ��E��
�� 
erobE l ��F����F N  ��GG n  ��HIH 7 ����JK
�� 
ctxtJ o  ������ 0 i  K l ��L����L \  ��MNM [  ��OPO o  ������ 0 i  P o  ������ 0 	chunksize 	chunkSizeN m  ������ ��  ��  I o  ������ 0 hextext hexText��  ��  ��  ��  ��  : Q��Q r  ��RSR \  ��TUT [  ��VWV o  ������ 0 	thenumber 	theNumberW o  ������ 0 i  U m  ������ S o      ���� 0 	thenumber 	theNumber��  �� 0 charref charRef& n ��XYX 7 ����Z[
�� 
ctxtZ o  ������ 0 i  [ l ��\����\ \  ��]^] [  ��_`_ o  ������ 0 i  ` o  ������ 0 	chunksize 	chunkSize^ m  ������ ��  ��  Y o  ������ 0 hextext hexText$ aba Z 5cd����c F  efe o  ���� 0 	isprecise 	isPrecisef l g����g =  hih o  ���� 0 	thenumber 	theNumberi [  
jkj o  ���� 0 	thenumber 	theNumberk m  	���� ��  ��  d R  1��lm
�� .ascrerr ****      � ****l m  -0nn �oo � H e x a d e c i m a l   t e x t   i s   t o o   l a r g e   t o   c o n v e r t   t o   n u m b e r   w i t h o u t   l o s i n g   p r e c i s i o n .m ��pq
�� 
errnp m  �����Yq ��r��
�� 
erobr l ,s����s N  ,tt n  +uvu 7 +��wx
�� 
ctxtw o  !#���� 0 i  x l $*y����y \  $*z{z [  %(|}| o  %&���� 0 i  } o  &'���� 0 	chunksize 	chunkSize{ m  ()���� ��  ��  v o  ���� 0 hextext hexText��  ��  ��  ��  ��  b ~��~ r  6>� o  67���� 0 	thenumber 	theNumber� n      ���  ;  <=� n 7<��� o  8<���� 
0 _list_  � o  78���� 0 
resultlist 
resultList��  �� 0 i   m  tu����  n u{��� 1  vz��
�� 
leng� o  uv���� 0 hextext hexText o  {|���� 0 	chunksize 	chunkSize ���� L  DK�� n DJ��� o  EI���� 
0 _list_  � o  DE���� 0 
resultlist 
resultList��  �   read as list of numbers   � ��� 0   r e a d   a s   l i s t   o f   n u m b e r s�=  6 ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ����
�� conswhit��  7 ���
�� conscase� ���
�� consnume�  3 R      �~��
�~ .ascrerr ****      � ****� o      �}�} 0 etext eText� �|��
�| 
errn� o      �{�{ 0 enumber eNumber� �z��
�z 
erob� o      �y�y 0 efrom eFrom� �x��w
�x 
errt� o      �v�v 
0 eto eTo�w  4 I  Tb�u��t�u 
0 _error  � ��� m  UX�� ���  p a r s e   h e x� ��� o  XY�s�s 0 etext eText� ��� o  YZ�r�r 0 enumber eNumber� ��� o  Z[�q�q 0 efrom eFrom� ��p� o  [\�o�o 
0 eto eTo�p  �t  $ ��� l     �n�m�l�n  �m  �l  � ��� l     �k�j�i�k  �j  �i  � ��� l     �h���h  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     �g���g  � !  General numeric operations   � ��� 6   G e n e r a l   n u m e r i c   o p e r a t i o n s� ��� l     �f�e�d�f  �e  �d  � ��� i  H K��� I     �c��b
�c .Mth:DeRanull���     doub� o      �a�a 0 x  �b  � Q     ���� L    �� ]    
��� l   ��`�_� c    ��� o    �^�^ 0 x  � m    �]
�] 
doub�`  �_  � l   	��\�[� ^    	��� 1    �Z
�Z 
pi  � m    �Y�Y ��\  �[  � R      �X��
�X .ascrerr ****      � ****� o      �W�W 0 etext eText� �V��
�V 
errn� o      �U�U 0 enumber eNumber� �T��
�T 
erob� o      �S�S 0 efrom eFrom� �R��Q
�R 
errt� o      �P�P 
0 eto eTo�Q  � I    �O��N�O 
0 _error  � ��� m    �� ���  r a d i a n s� ��� o    �M�M 0 etext eText� ��� o    �L�L 0 enumber eNumber� ��� o    �K�K 0 efrom eFrom� ��J� o    �I�I 
0 eto eTo�J  �N  � ��� l     �H�G�F�H  �G  �F  � ��� l     �E�D�C�E  �D  �C  � ��� i  L O��� I     �B��A
�B .Mth:RaDenull���     doub� o      �@�@ 0 x  �A  � Q     ���� L    �� ^    
��� l   ��?�>� c    ��� o    �=�= 0 x  � m    �<
�< 
doub�?  �>  � l   	��;�:� ^    	��� 1    �9
�9 
pi  � m    �8�8 ��;  �:  � R      �7��
�7 .ascrerr ****      � ****� o      �6�6 0 etext eText� �5��
�5 
errn� o      �4�4 0 enumber eNumber� �3��
�3 
erob� o      �2�2 0 efrom eFrom� �1��0
�1 
errt� o      �/�/ 
0 eto eTo�0  � I    �.��-�. 
0 _error  � ��� m    �� ���  d e g r e e s� ��� o    �,�, 0 etext eText� ��� o    �+�+ 0 enumber eNumber� ��� o    �*�* 0 efrom eFrom� ��)� o    �(�( 
0 eto eTo�)  �-  � �	 � l     �'�&�%�'  �&  �%  	  			 l     �$�#�"�$  �#  �"  	 			 l     �!� ��!  �   �  	 			 i  P S			 I     �		�
� .Mth:Abs_null���     nmbr		 o      �� 0 x  �  	 Q     )	
			
 k    		 			 r    			 c    			 o    �� 0 x  	 m    �
� 
nmbr	 o      �� 0 x  	 	�	 Z   	 		�		 A   	 			 o   	 
�� 0 x  	 m   
 ��  	 L    		 d    		 o    �� 0 x  �  	 L    		 o    �� 0 x  �  	 R      �		
� .ascrerr ****      � ****	 o      �� 0 etext eText	 �		 
� 
errn	 o      �� 0 enumber eNumber	  �	!	"
� 
erob	! o      �� 0 efrom eFrom	" �	#�
� 
errt	# o      �
�
 
0 eto eTo�  	 I    )�		$��	 
0 _error  	$ 	%	&	% m     !	'	' �	(	(  a b s	& 	)	*	) o   ! "�� 0 etext eText	* 	+	,	+ o   " #�� 0 enumber eNumber	, 	-	.	- o   # $�� 0 efrom eFrom	. 	/�	/ o   $ %�� 
0 eto eTo�  �  	 	0	1	0 l     ��� �  �  �   	1 	2	3	2 l     ��������  ��  ��  	3 	4	5	4 i  T W	6	7	6 I     ��	8��
�� .Mth:CmpNnull���     ****	8 J      	9	9 	:	;	: o      ���� 0 n1  	; 	<��	< o      ���� 0 n2  ��  ��  	7 Q     �	=	>	?	= k    �	@	@ 	A	B	A Z    �	C	D��	E	C =    	F	G	F l   	H����	H I   ��	I	J
�� .corecnte****       ****	I J    	K	K 	L	M	L o    ���� 0 n1  	M 	N��	N o    ���� 0 n2  ��  	J ��	O��
�� 
kocl	O m    	��
�� 
long��  ��  ��  	G m    ���� 	D Z   	P	Q����	P =    	R	S	R o    ���� 0 n1  	S o    ���� 0 n2  	Q L    	T	T m    ����  ��  ��  ��  	E k   ! �	U	U 	V	W	V r   ! 8	X	Y	X J   ! )	Z	Z 	[	\	[ c   ! $	]	^	] o   ! "���� 0 n1  	^ m   " #��
�� 
doub	\ 	_��	_ c   $ '	`	a	` o   $ %���� 0 n2  	a m   % &��
�� 
doub��  	Y J      	b	b 	c	d	c o      ���� 0 n1  	d 	e��	e o      ���� 0 n2  ��  	W 	f	g	f Z   9 T	h	i��	j	h =   9 <	k	l	k o   9 :���� 0 n1  	l m   : ;����  	i r   ? H	m	n	m ]   ? F	o	p	o o   ? D���� 0 _isequaldelta _isEqualDelta	p o   D E���� 0 n2  	n o      ���� 0 dn  ��  	j r   K T	q	r	q ]   K R	s	t	s o   K P���� 0 _isequaldelta _isEqualDelta	t o   P Q���� 0 n1  	r o      ���� 0 dn  	g 	u	v	u r   U Y	w	x	w d   U W	y	y o   U V���� 0 dn  	x o      ���� 0 dm  	v 	z	{	z Z  Z w	|	}����	| ?   Z ]	~		~ o   Z [���� 0 dm  	 o   [ \���� 0 dn  	} r   ` s	�	�	� J   ` d	�	� 	�	�	� o   ` a���� 0 dm  	� 	���	� o   a b���� 0 dn  ��  	� J      	�	� 	�	�	� o      ���� 0 dn  	� 	���	� o      ���� 0 dm  ��  ��  ��  	{ 	�	�	� r   x }	�	�	� \   x {	�	�	� o   x y���� 0 n2  	� o   y z���� 0 n1  	� o      ���� 0 d  	� 	���	� Z  ~ �	�	�����	� F   ~ �	�	�	� ?   ~ �	�	�	� o   ~ ���� 0 d  	� o    ����� 0 dm  	� A   � �	�	�	� o   � ����� 0 d  	� o   � ����� 0 dn  	� L   � �	�	� m   � �����  ��  ��  ��  	B 	���	� Z   � �	�	���	�	� A   � �	�	�	� o   � ����� 0 n1  	� o   � ����� 0 n2  	� L   � �	�	� m   � ���������  	� L   � �	�	� m   � ����� ��  	> R      ��	�	�
�� .ascrerr ****      � ****	� o      ���� 0 etext eText	� ��	�	�
�� 
errn	� o      ���� 0 enumber eNumber	� ��	�	�
�� 
erob	� o      ���� 0 efrom eFrom	� ��	���
�� 
errt	� o      ���� 
0 eto eTo��  	? I   � ���	����� 
0 _error  	� 	�	�	� m   � �	�	� �	�	�  c m p	� 	�	�	� o   � ����� 0 etext eText	� 	�	�	� o   � ����� 0 enumber eNumber	� 	�	�	� o   � ����� 0 efrom eFrom	� 	���	� o   � ����� 
0 eto eTo��  ��  	5 	�	�	� l     ��������  ��  ��  	� 	�	�	� l     ��������  ��  ��  	� 	�	�	� i  X [	�	�	� I     ��	���
�� .Mth:MinNnull���     ****	� o      ���� 0 thelist theList��  	� Q     W	�	�	�	� k    E	�	� 	�	�	� h    
��	��� 0 
listobject 
listObject	� j     ��	��� 
0 _list_  	� n    	�	�	� I    ��	����� "0 aslistparameter asListParameter	� 	���	� o    
���� 0 thelist theList��  ��  	� o     ���� 0 _support  	� 	�	�	� r    	�	�	� c    	�	�	� l   	�����	� n    	�	�	� 4   ��	�
�� 
cobj	� m    ���� 	� n   	�	�	� o    ���� 
0 _list_  	� o    ���� 0 
listobject 
listObject��  ��  	� m    ��
�� 
nmbr	� o      ���� 0 	theresult 	theResult	� 	�	�	� X    B	���	�	� k   ( =	�	� 	�	�	� r   ( /	�	�	� c   ( -	�	�	� n  ( +	�	�	� 1   ) +��
�� 
pcnt	� o   ( )���� 0 aref aRef	� m   + ,��
�� 
nmbr	� o      ���� 0 x  	� 	���	� Z  0 =	�	�����	� A   0 3	�	�	� o   0 1���� 0 x  	� o   1 2���� 0 	theresult 	theResult	� r   6 9	�	�	� o   6 7���� 0 x  	� o      ���� 0 	theresult 	theResult��  ��  ��  �� 0 aref aRef	� n   	�	�	� o    ���� 
0 _list_  	� o    ���� 0 
listobject 
listObject	� 	���	� L   C E	�	� o   C D���� 0 	theresult 	theResult��  	� R      ��	�	�
�� .ascrerr ****      � ****	� o      ���� 0 etext eText	� �	�	�
� 
errn	� o      �~�~ 0 enumber eNumber	� �}	�	�
�} 
erob	� o      �|�| 0 efrom eFrom	� �{	��z
�{ 
errt	� o      �y�y 
0 eto eTo�z  	� I   M W�x	��w�x 
0 _error  	� 	�	�	� m   N O	�	� �	�	�  m i n	� 	�	�	� o   O P�v�v 0 etext eText	� 	�	�	� o   P Q�u�u 0 enumber eNumber	� 	�	�	� o   Q R�t�t 0 efrom eFrom	� 
 �s
  o   R S�r�r 
0 eto eTo�s  �w  	� 


 l     �q�p�o�q  �p  �o  
 


 l     �n�m�l�n  �m  �l  
 


 i  \ _


 I     �k
	�j
�k .Mth:MaxNnull���     ****
	 o      �i�i 0 thelist theList�j  
 Q     W





 k    E

 


 h    
�h
�h 0 
listobject 
listObject
 j     �g
�g 
0 _list_  
 n    


 I    �f
�e�f "0 aslistparameter asListParameter
 
�d
 o    
�c�c 0 thelist theList�d  �e  
 o     �b�b 0 _support  
 


 r    


 c    


 l   
�a�`
 n    


 4   �_

�_ 
cobj
 m    �^�^ 
 n   
 
!
  o    �]�] 
0 _list_  
! o    �\�\ 0 
listobject 
listObject�a  �`  
 m    �[
�[ 
nmbr
 o      �Z�Z 0 	theresult 	theResult
 
"
#
" X    B
$�Y
%
$ k   ( =
&
& 
'
(
' r   ( /
)
*
) c   ( -
+
,
+ n  ( +
-
.
- 1   ) +�X
�X 
pcnt
. o   ( )�W�W 0 aref aRef
, m   + ,�V
�V 
nmbr
* o      �U�U 0 x  
( 
/�T
/ Z  0 =
0
1�S�R
0 ?   0 3
2
3
2 o   0 1�Q�Q 0 x  
3 o   1 2�P�P 0 	theresult 	theResult
1 r   6 9
4
5
4 o   6 7�O�O 0 x  
5 o      �N�N 0 	theresult 	theResult�S  �R  �T  �Y 0 aref aRef
% n   
6
7
6 o    �M�M 
0 _list_  
7 o    �L�L 0 
listobject 
listObject
# 
8�K
8 L   C E
9
9 o   C D�J�J 0 	theresult 	theResult�K  
 R      �I
:
;
�I .ascrerr ****      � ****
: o      �H�H 0 etext eText
; �G
<
=
�G 
errn
< o      �F�F 0 enumber eNumber
= �E
>
?
�E 
erob
> o      �D�D 0 efrom eFrom
? �C
@�B
�C 
errt
@ o      �A�A 
0 eto eTo�B  
 I   M W�@
A�?�@ 
0 _error  
A 
B
C
B m   N O
D
D �
E
E  m a x
C 
F
G
F o   O P�>�> 0 etext eText
G 
H
I
H o   P Q�=�= 0 enumber eNumber
I 
J
K
J o   Q R�<�< 0 efrom eFrom
K 
L�;
L o   R S�:�: 
0 eto eTo�;  �?  
 
M
N
M l     �9�8�7�9  �8  �7  
N 
O
P
O l     �6�5�4�6  �5  �4  
P 
Q
R
Q i  ` c
S
T
S I     �3
U
V
�3 .Mth:RouNnull���     nmbr
U o      �2�2 0 num  
V �1
W
X
�1 
Plac
W |�0�/
Y�.
Z�0  �/  
Y o      �-�- 0 decimalplaces decimalPlaces�.  
Z l     
[�,�+
[ m      �*�*  �,  �+  
X �)
\�(
�) 
Dire
\ |�'�&
]�%
^�'  �&  
] o      �$�$ &0 roundingdirection roundingDirection�%  
^ l     
_�#�"
_ m      �!
�! MRndRNhE�#  �"  �(  
T Q    �
`
a
b
` k   �
c
c 
d
e
d r    
f
g
f n   
h
i
h I    � 
j��  "0 asrealparameter asRealParameter
j 
k
l
k o    	�� 0 num  
l 
m�
m m   	 

n
n �
o
o  �  �  
i o    �� 0 _support  
g o      �� 0 num  
e 
p
q
p r    
r
s
r n   
t
u
t I    �
v�� (0 asintegerparameter asIntegerParameter
v 
w
x
w o    �� 0 decimalplaces decimalPlaces
x 
y�
y m    
z
z �
{
{  t o   p l a c e s�  �  
u o    �� 0 _support  
s o      �� 0 decimalplaces decimalPlaces
q 
|
}
| Z    8
~
��
~ >    "
�
�
� o     �� 0 decimalplaces decimalPlaces
� m     !��  
 k   % 4
�
� 
�
�
� r   % *
�
�
� a   % (
�
�
� m   % &�� 

� o   & '�� 0 decimalplaces decimalPlaces
� o      �� 0 themultiplier theMultiplier
� 
��
� l  + 4
�
�
�
� r   + 4
�
�
� ^   + 2
�
�
� ]   + 0
�
�
� ]   + .
�
�
� o   + ,�� 0 num  
� m   , -�� 

� o   . /�
�
 0 themultiplier theMultiplier
� m   0 1�	�	 

� o      �� 0 num  
��� multiplying and dividing by 10 before and after applying the multiplier helps avoid poor rounding results for some numbers due to inevitable loss of precision in floating-point math (e.g. `324.21 * 100 div 1 / 100` returns 324.2 but needs to be 324.21), though this hasn't been tested on all possible values for obvious reasons -- TO DO: shouldn't /10 be done after rounding is applied (in which case following calculations should use mod 10, etc)?   
� �
�
��   m u l t i p l y i n g   a n d   d i v i d i n g   b y   1 0   b e f o r e   a n d   a f t e r   a p p l y i n g   t h e   m u l t i p l i e r   h e l p s   a v o i d   p o o r   r o u n d i n g   r e s u l t s   f o r   s o m e   n u m b e r s   d u e   t o   i n e v i t a b l e   l o s s   o f   p r e c i s i o n   i n   f l o a t i n g - p o i n t   m a t h   ( e . g .   ` 3 2 4 . 2 1   *   1 0 0   d i v   1   /   1 0 0 `   r e t u r n s   3 2 4 . 2   b u t   n e e d s   t o   b e   3 2 4 . 2 1 ) ,   t h o u g h   t h i s   h a s n ' t   b e e n   t e s t e d   o n   a l l   p o s s i b l e   v a l u e s   f o r   o b v i o u s   r e a s o n s   - -   T O   D O :   s h o u l d n ' t   / 1 0   b e   d o n e   a f t e r   r o u n d i n g   i s   a p p l i e d   ( i n   w h i c h   c a s e   f o l l o w i n g   c a l c u l a t i o n s   s h o u l d   u s e   m o d   1 0 ,   e t c ) ?�  �  �  
} 
�
�
� Z   9�
�
�
�
�
� =  9 <
�
�
� o   9 :�� &0 roundingdirection roundingDirection
� l  : ;
���
� m   : ;�
� MRndRNhE�  �  
� Z   ? m
�
�
�
�
� E  ? K
�
�
� J   ? C
�
� 
�
�
� m   ? @
�
� ��      
� 
��
� m   @ A
�
� ?�      �  
� J   C J
�
� 
��
� `   C H
�
�
� l  C F
��� 
� ^   C F
�
�
� o   C D���� 0 num  
� m   D E���� �  �   
� m   F G���� �  
� l  N S
�
�
�
� r   N S
�
�
� _   N Q
�
�
� o   N O���� 0 num  
� m   O P���� 
� o      ���� 0 num  
� T N if num ends in .5 and its div is even then round toward zero so it stays even   
� �
�
� �   i f   n u m   e n d s   i n   . 5   a n d   i t s   d i v   i s   e v e n   t h e n   r o u n d   t o w a r d   z e r o   s o   i t   s t a y s   e v e n
� 
�
�
� ?   V Y
�
�
� o   V W���� 0 num  
� m   W X����  
� 
���
� l  \ c
�
�
�
� r   \ c
�
�
� _   \ a
�
�
� l  \ _
�����
� [   \ _
�
�
� o   \ ]���� 0 num  
� m   ] ^
�
� ?�      ��  ��  
� m   _ `���� 
� o      ���� 0 num  
� H B else round to nearest whole digit (.5 will round up if positive�)   
� �
�
� �   e l s e   r o u n d   t o   n e a r e s t   w h o l e   d i g i t   ( . 5   w i l l   r o u n d   u p   i f   p o s i t i v e & )��  
� l  f m
�
�
�
� r   f m
�
�
� _   f k
�
�
� l  f i
�����
� \   f i
�
�
� o   f g���� 0 num  
� m   g h
�
� ?�      ��  ��  
� m   i j���� 
� o      ���� 0 num  
� 4 . (�or down if negative to give an even result)   
� �
�
� \   ( & o r   d o w n   i f   n e g a t i v e   t o   g i v e   a n   e v e n   r e s u l t )
� 
�
�
� =  p s
�
�
� o   p q���� &0 roundingdirection roundingDirection
� l  q r
�����
� m   q r��
�� MRndRNhT��  ��  
� 
�
�
� Z   v �
�
�
�
�
� E  v �
�
�
� J   v z
�
� 
�
�
� m   v w
�
� ��      
� 
���
� m   w x
�
� ?�      ��  
� J   z 
�
� 
���
� `   z }
�
�
� o   z {���� 0 num  
� m   { |���� ��  
� l  � �
�
�
�
� r   � �
�
�
� _   � �
�
�
� o   � ����� 0 num  
� m   � ����� 
� o      ���� 0 num  
� 0 * if num ends in .5 then round towards zero   
� �
�
� T   i f   n u m   e n d s   i n   . 5   t h e n   r o u n d   t o w a r d s   z e r o
� 
�
�
� ?   � �
�
�
� o   � ����� 0 num  
� m   � �����  
� 
���
� l  � �
�
�
�
� r   � �
�
�
� _   � �   l  � ����� [   � � o   � ����� 0 num   m   � � ?�      ��  ��   m   � ����� 
� o      ���� 0 num  
� ( " else round to nearest whole digit   
� � D   e l s e   r o u n d   t o   n e a r e s t   w h o l e   d i g i t��  
� r   � � _   � �	
	 l  � ����� \   � � o   � ����� 0 num   m   � � ?�      ��  ��  
 m   � �����  o      ���� 0 num  
�  =  � � o   � ����� &0 roundingdirection roundingDirection l  � ����� m   � ���
�� MRndRNhF��  ��    Z   � � E  � � J   � �  m   � � ��        ��  m   � �!! ?�      ��   J   � �"" #��# `   � �$%$ o   � ����� 0 num  % m   � ����� ��   l  � �&'(& Z   � �)*��+) ?   � �,-, o   � ����� 0 num  - m   � �����  * r   � �./. [   � �010 _   � �232 o   � ����� 0 num  3 m   � ����� 1 m   � ����� / o      ���� 0 num  ��  + r   � �454 \   � �676 _   � �898 o   � ����� 0 num  9 m   � ����� 7 m   � ����� 5 o      ���� 0 num  ' 0 * if num ends in .5 then round towards zero   ( �:: T   i f   n u m   e n d s   i n   . 5   t h e n   r o u n d   t o w a r d s   z e r o ;<; ?   � �=>= o   � ����� 0 num  > m   � �����  < ?��? l  � �@AB@ r   � �CDC _   � �EFE l  � �G����G [   � �HIH o   � ����� 0 num  I m   � �JJ ?�      ��  ��  F m   � ����� D o      ���� 0 num  A ( " else round to nearest whole digit   B �KK D   e l s e   r o u n d   t o   n e a r e s t   w h o l e   d i g i t��   r   � �LML _   � �NON l  � �P����P \   � �QRQ o   � ����� 0 num  R m   � �SS ?�      ��  ��  O m   � ����� M o      ���� 0 num   TUT =  � �VWV o   � ����� &0 roundingdirection roundingDirectionW l  � �X����X m   � ���
�� MRndRN_T��  ��  U YZY r   � �[\[ _   � �]^] o   � ����� 0 num  ^ m   � ����� \ o      ���� 0 num  Z _`_ =  � �aba o   � ����� &0 roundingdirection roundingDirectionb l  � �c����c m   � ���
�� MRndRN_F��  ��  ` ded Z   'fghif =   jkj `   lml o   ���� 0 num  m m  ���� k m  ����  g r  non _  pqp o  	���� 0 num  q m  	
���� o o      ���� 0 num  h rsr ?  tut o  ���� 0 num  u m  ����  s v��v r  wxw [  yzy _  {|{ o  ���� 0 num  | m  ���� z m  ���� x o      ���� 0 num  ��  i r   '}~} \   %� _   #��� o   !���� 0 num  � m  !"���� � m  #$���� ~ o      ���� 0 num  e ��� = *-��� o  *+���� &0 roundingdirection roundingDirection� l +,������ m  +,��
�� MRndRN_U��  ��  � ��� l 0O���� Z  0O������ G  0=��� A  03��� o  01���� 0 num  � m  12����  � =  6;��� `  69��� o  67���� 0 num  � m  78���� � m  9:����  � r  @E��� _  @C��� o  @A���� 0 num  � m  AB���� � o      ���� 0 num  ��  � r  HO��� [  HM��� _  HK��� o  HI���� 0 num  � m  IJ���� � m  KL���� � o      ���� 0 num  �   ceil()   � ���    c e i l ( )� ��� = RW��� o  RS���� &0 roundingdirection roundingDirection� l SV������ m  SV��
�� MRndRN_D��  ��  � ���� l Zy���� Z  Zy������ G  Zg��� ?  Z]��� o  Z[���� 0 num  � m  [\����  � =  `e��� `  `c��� o  `a�� 0 num  � m  ab�~�~ � m  cd�}�}  � r  jo��� _  jm��� o  jk�|�| 0 num  � m  kl�{�{ � o      �z�z 0 num  ��  � r  ry��� \  rw��� _  ru��� o  rs�y�y 0 num  � m  st�x�x � m  uv�w�w � o      �v�v 0 num  �   floor()   � ���    f l o o r ( )��  
� n |���� I  ���u��t�u >0 throwinvalidconstantparameter throwInvalidConstantParameter� ��� o  ���s�s &0 roundingdirection roundingDirection� ��r� m  ���� ���  b y�r  �t  � o  |��q�q 0 _support  
� ��p� Z  ������� =  ����� o  ���o�o 0 decimalplaces decimalPlaces� m  ���n�n  � L  ���� _  ����� o  ���m�m 0 num  � m  ���l�l � ��� A  ����� o  ���k�k 0 decimalplaces decimalPlaces� m  ���j�j  � ��i� L  ���� _  ����� o  ���h�h 0 num  � o  ���g�g 0 themultiplier theMultiplier�i  � L  ���� ^  ����� o  ���f�f 0 num  � o  ���e�e 0 themultiplier theMultiplier�p  
a R      �d��
�d .ascrerr ****      � ****� o      �c�c 0 etext eText� �b��
�b 
errn� o      �a�a 0 enumber eNumber� �`��
�` 
erob� o      �_�_ 0 efrom eFrom� �^��]
�^ 
errt� o      �\�\ 
0 eto eTo�]  
b I  ���[��Z�[ 
0 _error  � ��� m  ���� ���  r o u n d   n u m b e r� ��� o  ���Y�Y 0 etext eText� ��� o  ���X�X 0 enumber eNumber� ��� o  ���W�W 0 efrom eFrom� ��V� o  ���U�U 
0 eto eTo�V  �Z  
R ��� l     �T�S�R�T  �S  �R  � ��� l     �Q�P�O�Q  �P  �O  � ��� l     �N���N  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     �M���M  �   Trigonometry   � ���    T r i g o n o m e t r y�    l     �L�K�J�L  �K  �J    i  d g I      �I�H�I 0 _sin   �G o      �F�F 0 x  �G  �H   k     � 	
	 l    	 r     	 ]      l    �E�D `      o     �C�C 0 x   m    �B�Bh�E  �D   l   �A�@ ^     1    �?
�? 
pi   m    �>�> ��A  �@   o      �=�= 0 x   &   convert from degrees to radians    � @   c o n v e r t   f r o m   d e g r e e s   t o   r a d i a n s
  r   
  A   
  o   
 �<�< 0 x   m    �;�;   o      �:�: 0 isneg isNeg   Z   !"�9�8! o    �7�7 0 isneg isNeg" r    #$# d    %% o    �6�6 0 x  $ o      �5�5 0 x  �9  �8    &'& r    &()( _    $*+* l   ",�4�3, ]    "-.- o    �2�2 0 x  . l   !/�1�0/ ^    !010 m    �/�/ 1 1     �.
�. 
pi  �1  �0  �4  �3  + m   " #�-�- ) o      �,�, 0 y  ' 232 r   ' 2454 \   ' 0676 o   ' (�+�+ 0 y  7 ]   ( /898 l  ( -:�*�): _   ( -;<; ]   ( +=>= o   ( )�(�( 0 y  > m   ) *?? ?�      < m   + ,�'�' �*  �)  9 m   - .�&�& 5 o      �%�% 0 z  3 @A@ Z   3 JBC�$�#B =  3 8DED `   3 6FGF o   3 4�"�" 0 z  G m   4 5�!�! E m   6 7� �  C k   ; FHH IJI r   ; @KLK [   ; >MNM o   ; <�� 0 z  N m   < =�� L o      �� 0 z  J O�O r   A FPQP [   A DRSR o   A B�� 0 y  S m   B C�� Q o      �� 0 y  �  �$  �#  A TUT r   K PVWV `   K NXYX o   K L�� 0 z  Y m   L M�� W o      �� 0 z  U Z[Z Z   Q e\]��\ ?   Q T^_^ o   Q R�� 0 z  _ m   R S�� ] k   W a`` aba r   W [cdc H   W Yee o   W X�� 0 isneg isNegd o      �� 0 isneg isNegb f�f r   \ aghg \   \ _iji o   \ ]�� 0 z  j m   ] ^�� h o      �� 0 z  �  �  �  [ klk r   f umnm \   f sopo l  f oq��
q \   f orsr l  f kt�	�t \   f kuvu o   f g�� 0 x  v ]   g jwxw o   g h�� 0 y  x m   h iyy ?�!�?��v�	  �  s ]   k nz{z o   k l�� 0 y  { m   l m|| >dD,���J�  �
  p ]   o r}~} o   o p�� 0 y  ~ m   p q <�F���P�n o      �� 0 z2  l ��� r   v {��� ]   v y��� o   v w�� 0 z2  � o   w x�� 0 z2  � o      � �  0 zz  � ��� Z   | ������� G   | ���� =  | ��� o   | }���� 0 z  � m   } ~���� � =  � ���� o   � ����� 0 z  � m   � ����� � r   � ���� [   � ���� \   � ���� m   � ��� ?�      � ^   � ���� o   � ����� 0 zz  � m   � ����� � ]   � ���� ]   � ���� o   � ����� 0 zz  � o   � ����� 0 zz  � l  � ������� [   � ���� ]   � ���� l  � ������� \   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� \   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� m   � ��� ���I���� o   � ����� 0 zz  � m   � ��� >!�{N>���  ��  � o   � ����� 0 zz  � m   � ��� >�~O~�K���  ��  � o   � ����� 0 zz  � m   � ��� >���D���  ��  � o   � ����� 0 zz  � m   � ��� ?V�l�=���  ��  � o   � ����� 0 zz  � m   � ��� ?�UUUV���  ��  � o      ���� 0 y  ��  � r   � ���� [   � ���� o   � ����� 0 z2  � ]   � ���� ]   � ���� o   � ����� 0 z2  � o   � ����� 0 zz  � l  � ������� \   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� \   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� \   � ���� ]   � ���� m   � ��� =���ќ�� o   � ����� 0 zz  � m   � ��� >Z��)[��  ��  � o   � ����� 0 zz  � m   � ��� >��V}H���  ��  � o   � ����� 0 zz  � m   � ��� ?*������  ��  � o   � ����� 0 zz  � m   � ��� ?�"w��  ��  � o   � ����� 0 zz  � m   � ��� ?�UUUU�?��  ��  � o      ���� 0 y  � ��� Z  � �������� o   � ����� 0 isneg isNeg� r   � ���� d   � ��� o   � ����� 0 y  � o      ���� 0 y  ��  ��  � ���� L   � ��� o   � ����� 0 y  ��   ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  h k��� I     �����
�� .Mth:Sin_null���     doub� o      ���� 0 x  ��  � Q     ���� L    �� I    ������� 0 _sin  � ���� c    ��� o    ���� 0 x  � m    ��
�� 
nmbr��  ��  � R      �� 
�� .ascrerr ****      � ****  o      ���� 0 etext eText ��
�� 
errn o      ���� 0 enumber eNumber ��
�� 
erob o      ���� 0 efrom eFrom ����
�� 
errt o      ���� 
0 eto eTo��  � I    ������ 
0 _error   	 m    

 �  s i n	  o    ���� 0 etext eText  o    ���� 0 enumber eNumber  o    ���� 0 efrom eFrom �� o    ���� 
0 eto eTo��  ��  �  l     ��������  ��  ��    l     ��������  ��  ��    i  l o I     ����
�� .Mth:Cos_null���     doub o      ���� 0 x  ��   Q       L     I    �� ���� 0 _sin    !��! [    	"#" l   $����$ c    %&% o    ���� 0 x  & m    ��
�� 
nmbr��  ��  # m    ���� Z��  ��   R      ��'(
�� .ascrerr ****      � ****' o      ���� 0 etext eText( ��)*
�� 
errn) o      ���� 0 enumber eNumber* ��+,
�� 
erob+ o      ���� 0 efrom eFrom, ��-��
�� 
errt- o      ���� 
0 eto eTo��   I     ��.���� 
0 _error  . /0/ m    11 �22  c o s0 343 o    ���� 0 etext eText4 565 o    ���� 0 enumber eNumber6 787 o    ���� 0 efrom eFrom8 9��9 o    ���� 
0 eto eTo��  ��   :;: l     ��������  ��  ��  ; <=< l     ��������  ��  ��  = >?> i  p s@A@ I     ��B��
�� .Mth:Tan_null���     doubB o      ���� 0 x  ��  A k    CC DED l     ��FG��  F a [ note: this starts to lose accuracy between 89.9999999 and 90�, but should be 'good enough'   G �HH �   n o t e :   t h i s   s t a r t s   t o   l o s e   a c c u r a c y   b e t w e e n   8 9 . 9 9 9 9 9 9 9   a n d   9 0 � ,   b u t   s h o u l d   b e   ' g o o d   e n o u g h 'E I��I Q    JKLJ k    �MM NON r    PQP c    RSR o    �� 0 x  S m    �~
�~ 
nmbrQ o      �}�} 0 x  O TUT l  	 #VWXV Z  	 #YZ�|�{Y G   	 [\[ =  	 ]^] o   	 
�z�z 0 x  ^ m   
 �y�y Z\ =   _`_ o    �x�x 0 x  ` m    �w�wZ R    �vab
�v .ascrerr ****      � ****a m    cc �dd F I n v a l i d   n u m b e r   ( r e s u l t   w o u l d   b e  " ) .b �uef
�u 
errne m    �t�t�sf �sg�r
�s 
erobg o    �q�q 0 x  �r  �|  �{  W 4 . -2701 normally indicates divide-by-zero error   X �hh \   - 2 7 0 1   n o r m a l l y   i n d i c a t e s   d i v i d e - b y - z e r o   e r r o rU iji l  $ -klmk r   $ -non ]   $ +pqp l  $ 'r�p�or `   $ 'sts o   $ %�n�n 0 x  t m   % &�m�mh�p  �o  q l  ' *u�l�ku ^   ' *vwv 1   ' (�j
�j 
pi  w m   ( )�i�i ��l  �k  o o      �h�h 0 x  l &   convert from degrees to radians   m �xx @   c o n v e r t   f r o m   d e g r e e s   t o   r a d i a n sj yzy r   . 3{|{ A   . 1}~} o   . /�g�g 0 x  ~ m   / 0�f�f  | o      �e�e 0 isneg isNegz � Z  4 @���d�c� o   4 5�b�b 0 isneg isNeg� r   8 <��� d   8 :�� o   8 9�a�a 0 x  � o      �`�` 0 x  �d  �c  � ��� r   A J��� _   A H��� l  A F��_�^� ^   A F��� o   A B�]�] 0 x  � l  B E��\�[� ^   B E��� 1   B C�Z
�Z 
pi  � m   C D�Y�Y �\  �[  �_  �^  � m   F G�X�X � o      �W�W 0 y  � ��� r   K V��� \   K T��� o   K L�V�V 0 y  � ]   L S��� l  L Q��U�T� _   L Q��� ]   L O��� o   L M�S�S 0 y  � m   M N�� ?�      � m   O P�R�R �U  �T  � m   Q R�Q�Q � o      �P�P 0 z  � ��� Z   W n���O�N� =  W \��� `   W Z��� o   W X�M�M 0 z  � m   X Y�L�L � m   Z [�K�K � k   _ j�� ��� r   _ d��� [   _ b��� o   _ `�J�J 0 z  � m   ` a�I�I � o      �H�H 0 z  � ��G� r   e j��� [   e h��� o   e f�F�F 0 y  � m   f g�E�E � o      �D�D 0 y  �G  �O  �N  � ��� r   o ���� \   o ~��� l  o x��C�B� \   o x��� l  o t��A�@� \   o t��� o   o p�?�? 0 x  � ]   p s��� o   p q�>�> 0 y  � m   q r�� ?�!�P M�A  �@  � ]   t w��� o   t u�=�= 0 y  � m   u v�� >A�`  �C  �B  � ]   x }��� o   x y�<�< 0 y  � m   y |�� <��&3\� o      �;�; 0 z2  � ��� r   � ���� ]   � ���� o   � ��:�: 0 z2  � o   � ��9�9 0 z2  � o      �8�8 0 zz  � ��� Z   � ����7�� ?   � ���� o   � ��6�6 0 zz  � m   � ��� =����+�� r   � ���� [   � ���� o   � ��5�5 0 z2  � ^   � ���� ]   � ���� ]   � ���� o   � ��4�4 0 z2  � o   � ��3�3 0 zz  � l  � ���2�1� \   � ���� ]   � ���� l  � ���0�/� [   � ���� ]   � ���� m   � ��� �ɒ��O?D� o   � ��.�. 0 zz  � m   � ��� A1������0  �/  � o   � ��-�- 0 zz  � m   � ��� Aq��)�y�2  �1  � l  � ���,�+� \   � ���� ]   � ���� l  � ���*�)� [   � ���� ]   � ���� l  � ���(�'� \   � ���� ]   � ���� l  � ���&�%� [   � ���� o   � ��$�$ 0 zz  � m   � �   @ʸ��et�&  �%  � o   � ��#�# 0 zz  � m   � � A4'�X*���(  �'  � o   � ��"�" 0 zz  � m   � � Awُ�����*  �)  � o   � ��!�! 0 zz  � m   � � A���<�Z6�,  �+  � o      � �  0 y  �7  � r   � � o   � ��� 0 z2   o      �� 0 y  �  Z  � �	�� G   � �

 =  � � o   � ��� 0 z   m   � ���  =  � � o   � ��� 0 z   m   � ��� 	 r   � � ^   � � m   � ����� o   � ��� 0 y   o      �� 0 y  �  �    Z  � ��� o   � ��� 0 isneg isNeg r   � � d   � � o   � ��� 0 y   o      �� 0 y  �  �   � L   � � o   � ��� 0 y  �  K R      �
� .ascrerr ****      � **** o      �� 0 etext eText � 
� 
errn o      �
�
 0 enumber eNumber  �	!"
�	 
erob! o      �� 0 efrom eFrom" �#�
� 
errt# o      �� 
0 eto eTo�  L I   ��$�� 
0 _error  $ %&% m   � �'' �((  t a n& )*) o   � ��� 0 etext eText* +,+ o   � ��� 0 enumber eNumber, -.- o   � �� �  0 efrom eFrom. /��/ o   � ����� 
0 eto eTo��  �  ��  ? 010 l     ��������  ��  ��  1 232 l     ��������  ��  ��  3 454 l     ��67��  6  -----   7 �88 
 - - - - -5 9:9 l     ��;<��  ;   inverse   < �==    i n v e r s e: >?> l     ��������  ��  ��  ? @A@ i  t wBCB I      ��D���� 	0 _asin  D E��E o      ���� 0 x  ��  ��  C k     �FF GHG r     IJI A     KLK o     ���� 0 x  L m    ����  J o      ���� 0 isneg isNegH MNM Z   OP����O o    ���� 0 isneg isNegP r   
 QRQ d   
 SS o   
 ���� 0 x  R o      ���� 0 x  ��  ��  N TUT Z   %VW����V ?    XYX o    ���� 0 x  Y m    ���� W R    !��Z[
�� .ascrerr ****      � ****Z m     \\ �]] T I n v a l i d   n u m b e r   ( n o t   b e t w e e n   - 1 . 0   a n d   1 . 0 ) .[ ��^_
�� 
errn^ m    �����Y_ ��`��
�� 
erob` o    ���� 0 x  ��  ��  ��  U aba Z   & �cdefc ?   & )ghg o   & '���� 0 x  h m   ' (ii ?�      d k   , jj klk r   , 1mnm \   , /opo m   , -���� p o   - .���� 0 x  n o      ���� 0 zz  l qrq r   2 Wsts ^   2 Uuvu ]   2 Ewxw o   2 3���� 0 zz  x l  3 Dy����y [   3 Dz{z ]   3 B|}| l  3 @~����~ \   3 @� ]   3 >��� l  3 <������ [   3 <��� ]   3 :��� l  3 8������ \   3 8��� ]   3 6��� m   3 4�� ?hOØ��� o   4 5���� 0 zz  � m   6 7�� ?��Y�,���  ��  � o   8 9���� 0 zz  � m   : ;�� @����?���  ��  � o   < =���� 0 zz  � m   > ?�� @9����"��  ��  } o   @ A���� 0 zz  { m   B C�� @<�b@����  ��  v l  E T������ [   E T��� ]   E R��� l  E P������ \   E P��� ]   E N��� l  E L������ [   E L��� ]   E J��� l  E H������ \   E H��� o   E F���� 0 zz  � m   F G�� @5򢶿]R��  ��  � o   H I���� 0 zz  � m   J K�� @bb�j1��  ��  � o   L M���� 0 zz  � m   N O�� @w���c���  ��  � o   P Q���� 0 zz  � m   R S�� @ug	��D���  ��  t o      ���� 0 p  r ��� r   X _��� a   X ]��� l  X [������ [   X [��� o   X Y���� 0 zz  � o   Y Z���� 0 zz  ��  ��  � m   [ \�� ?�      � o      ���� 0 zz  � ��� r   ` i��� \   ` g��� l  ` e������ ^   ` e��� 1   ` c��
�� 
pi  � m   c d���� ��  ��  � o   e f���� 0 zz  � o      ���� 0 z  � ��� r   j s��� \   j q��� ]   j m��� o   j k���� 0 zz  � o   k l���� 0 p  � m   m p�� <��&3\
� o      ���� 0 zz  � ���� r   t ��� [   t }��� \   t w��� o   t u���� 0 z  � o   u v���� 0 zz  � l  w |������ ^   w |��� 1   w z��
�� 
pi  � m   z {���� ��  ��  � o      ���� 0 z  ��  e ��� A   � ���� o   � ����� 0 x  � m   � ��� >Ey��0�:� ���� r   � ���� o   � ����� 0 x  � o      ���� 0 z  ��  f k   � ��� ��� r   � ���� ]   � ���� o   � ����� 0 x  � o   � ����� 0 x  � o      ���� 0 zz  � ���� r   � ���� [   � ���� ]   � ���� ^   � ���� ]   � ���� o   � ����� 0 zz  � l  � ������� \   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� \   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� \   � ���� ]   � �� � m   � � ?qk��v�  o   � ����� 0 zz  � m   � � ?�CA3>M���  ��  � o   � ����� 0 zz  � m   � � @�K�/��  ��  � o   � ����� 0 zz  � m   � � @0C1�'����  ��  � o   � ����� 0 zz  � m   � � @3��w����  ��  � o   � ����� 0 zz  � m   � � @ elΰ8��  ��  � l  � ����� \   � �	 ]   � �

 l  � ����� [   � � ]   � � l  � ����� \   � � ]   � � l  � ����� [   � � ]   � � l  � ����� \   � � o   � ����� 0 zz   m   � � @-{Y^���  ��   o   � ����� 0 zz   m   � � @Q��%��6��  ��   o   � ����� 0 zz   m   � �   @be�m5v���  ��   o   � ����� 0 zz   m   � �!! @apV������  ��   o   � ����� 0 zz  	 m   � �"" @H�"
6���  ��  � o   � ����� 0 x  � o   � ����� 0 x  � o      �� 0 z  ��  b #$# Z  � �%&�~�}% o   � ��|�| 0 isneg isNeg& r   � �'(' d   � �)) o   � ��{�{ 0 z  ( o      �z�z 0 z  �~  �}  $ *�y* L   � �++ ^   � �,-, o   � ��x�x 0 z  - l  � �.�w�v. ^   � �/0/ 1   � ��u
�u 
pi  0 m   � ��t�t ��w  �v  �y  A 121 l     �s�r�q�s  �r  �q  2 343 l     �p�o�n�p  �o  �n  4 565 l     �m�l�k�m  �l  �k  6 787 i  x {9:9 I     �j;�i
�j .Mth:Sinanull���     doub; o      �h�h 0 x  �i  : Q     <=>< L    ?? I    �g@�f�g 	0 _asin  @ A�eA c    BCB o    �d�d 0 x  C m    �c
�c 
nmbr�e  �f  = R      �bDE
�b .ascrerr ****      � ****D o      �a�a 0 etext eTextE �`FG
�` 
errnF o      �_�_ 0 enumber eNumberG �^HI
�^ 
erobH o      �]�] 0 efrom eFromI �\J�[
�\ 
errtJ o      �Z�Z 
0 eto eTo�[  > I    �YK�X�Y 
0 _error  K LML m    NN �OO  a s i nM PQP o    �W�W 0 etext eTextQ RSR o    �V�V 0 enumber eNumberS TUT o    �U�U 0 efrom eFromU V�TV o    �S�S 
0 eto eTo�T  �X  8 WXW l     �R�Q�P�R  �Q  �P  X YZY l     �O�N�M�O  �N  �M  Z [\[ i  | ]^] I     �L_�K
�L .Mth:Cosanull���     doub_ o      �J�J 0 x  �K  ^ Q      `ab` L    cc \    ded m    �I�I Ze l   f�H�Gf I    �Fg�E�F 	0 _asin  g h�Dh c    iji o    �C�C 0 x  j m    �B
�B 
nmbr�D  �E  �H  �G  a R      �Akl
�A .ascrerr ****      � ****k o      �@�@ 0 etext eTextl �?mn
�? 
errnm o      �>�> 0 enumber eNumbern �=op
�= 
erobo o      �<�< 0 efrom eFromp �;q�:
�; 
errtq o      �9�9 
0 eto eTo�:  b I     �8r�7�8 
0 _error  r sts m    uu �vv  a c o st wxw o    �6�6 0 etext eTextx yzy o    �5�5 0 enumber eNumberz {|{ o    �4�4 0 efrom eFrom| }�3} o    �2�2 
0 eto eTo�3  �7  \ ~~ l     �1�0�/�1  �0  �/   ��� l     �.�-�,�.  �-  �,  � ��� i  � ���� I     �+��*
�+ .Mth:Tananull���     doub� o      �)�) 0 x  �*  � Q     *���� k    �� ��� r    ��� c    ��� o    �(�( 0 x  � m    �'
�' 
nmbr� o      �&�& 0 x  � ��%� L   	 �� I   	 �$��#�$ 	0 _asin  � ��"� ^   
 ��� o   
 �!�! 0 x  � l   �� �� a    ��� l   ���� [    ��� ]    ��� o    �� 0 x  � o    �� 0 x  � m    �� �  �  � m    �� ?�      �   �  �"  �#  �%  � R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo�  � I     *���� 
0 _error  � ��� m   ! "�� ���  a t a n� ��� o   " #�� 0 etext eText� ��� o   # $�� 0 enumber eNumber� ��� o   $ %�� 0 efrom eFrom� ��� o   % &�
�
 
0 eto eTo�  �  � ��� l     �	���	  �  �  � ��� l     ����  �  �  � ��� l     ����  �  -----   � ��� 
 - - - - -� ��� l     ����  �   hyperbolic   � ���    h y p e r b o l i c� ��� l     �� ���  �   ��  � ��� i  � ���� I     �����
�� .Mth:Sinhnull���     doub� o      ���� 0 x  ��  � Q     .���� k    �� ��� r    ��� c    ��� o    ���� 0 x  � m    ��
�� 
nmbr� o      ���� 0 x  � ���� L   	 �� ]   	 ��� m   	 
�� ?�      � l  
 ������ \   
 ��� a   
 ��� o   
 ���� 	0 __e__  � o    ���� 0 x  � a    ��� o    ���� 	0 __e__  � d    �� o    ���� 0 x  ��  ��  ��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I   $ .������� 
0 _error  � ��� m   % &�� ��� 
 a s i n h� ��� o   & '���� 0 etext eText� ��� o   ' (���� 0 enumber eNumber� ��� o   ( )���� 0 efrom eFrom� ���� o   ) *���� 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I     �����
�� .Mth:Coshnull���     doub� o      ���� 0 x  ��  � Q     .���� k    �� � � r     c     o    ���� 0 x   m    ��
�� 
nmbr o      ���� 0 x    �� L   	  ]   	  m   	 
		 ?�       l  
 
����
 [   
  a   
  o   
 ���� 	0 __e__   o    ���� 0 x   a     o    ���� 	0 __e__   d     o    ���� 0 x  ��  ��  ��  � R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��
�� 
errn o      ���� 0 enumber eNumber ��
�� 
erob o      ���� 0 efrom eFrom ����
�� 
errt o      ���� 
0 eto eTo��  � I   $ .������ 
0 _error    m   % & � 
 a c o s h  o   & '���� 0 etext eText  !  o   ' (���� 0 enumber eNumber! "#" o   ( )���� 0 efrom eFrom# $��$ o   ) *���� 
0 eto eTo��  ��  � %&% l     ��������  ��  ��  & '(' l     ��������  ��  ��  ( )*) i  � �+,+ I     ��-��
�� .Mth:Tanhnull���     doub- o      ���� 0 x  ��  , Q     =./0. k    +11 232 r    454 c    676 o    ���� 0 x  7 m    ��
�� 
nmbr5 o      ���� 0 x  3 8��8 L   	 +99 ^   	 *:;: l  	 <����< \   	 =>= a   	 ?@? o   	 ���� 	0 __e__  @ o    ���� 0 x  > a    ABA o    ���� 	0 __e__  B d    CC o    ���� 0 x  ��  ��  ; l   )D����D [    )EFE a     GHG o    ���� 	0 __e__  H o    ���� 0 x  F a     (IJI o     %���� 	0 __e__  J d   % 'KK o   % &���� 0 x  ��  ��  ��  / R      ��LM
�� .ascrerr ****      � ****L o      ���� 0 etext eTextM ��NO
�� 
errnN o      ���� 0 enumber eNumberO ��PQ
�� 
erobP o      ���� 0 efrom eFromQ ��R��
�� 
errtR o      ���� 
0 eto eTo��  0 I   3 =��S���� 
0 _error  S TUT m   4 5VV �WW 
 a t a n hU XYX o   5 6���� 0 etext eTextY Z[Z o   6 7���� 0 enumber eNumber[ \]\ o   7 8���� 0 efrom eFrom] ^��^ o   8 9���� 
0 eto eTo��  ��  * _`_ l     ��������  ��  ��  ` aba l     ��������  ��  ��  b cdc l     ��ef��  e J D--------------------------------------------------------------------   f �gg � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -d hih l     ��jk��  j   Logarithms   k �ll    L o g a r i t h m si mnm l     ��������  ��  ��  n opo i  � �qrq I      ��s���� 
0 _frexp  s t��t o      ���� 0 m  ��  ��  r k     nuu vwv Z    xy����x =    z{z o     ���� 0 m  { m    ����  y L    || J    
}} ~~ m    ��          ���� m    ����  ��  ��  ��  w ��� r    ��� A    ��� o    ���� 0 m  � m    ��  � o      �~�~ 0 isneg isNeg� ��� Z   "���}�|� o    �{�{ 0 isneg isNeg� r    ��� d    �� o    �z�z 0 m  � o      �y�y 0 m  �}  �|  � ��� r   # &��� m   # $�x�x  � o      �w�w 0 e  � ��� W   ' [��� Z   7 V���v�� @   7 :��� o   7 8�u�u 0 m  � m   8 9�t�t � k   = H�� ��� r   = B��� ^   = @��� o   = >�s�s 0 m  � m   > ?�r�r � o      �q�q 0 m  � ��p� r   C H��� [   C F��� o   C D�o�o 0 e  � m   D E�n�n � o      �m�m 0 e  �p  �v  � k   K V�� ��� r   K P��� ]   K N��� o   K L�l�l 0 m  � m   L M�k�k � o      �j�j 0 m  � ��i� r   Q V��� \   Q T��� o   Q R�h�h 0 e  � m   R S�g�g � o      �f�f 0 e  �i  � F   + 6��� @   + .��� o   + ,�e�e 0 m  � m   , -�� ?�      � A   1 4��� o   1 2�d�d 0 m  � m   2 3�c�c � ��� Z  \ h���b�a� o   \ ]�`�` 0 isneg isNeg� r   ` d��� d   ` b�� o   ` a�_�_ 0 m  � o      �^�^ 0 m  �b  �a  � ��]� L   i n�� J   i m�� ��� o   i j�\�\ 0 m  � ��[� o   j k�Z�Z 0 e  �[  �]  p ��� l     �Y�X�W�Y  �X  �W  � ��� l     �V�U�T�V  �U  �T  � ��� i  � ���� I      �S��R�S 	0 _logn  � ��Q� o      �P�P 0 x  �Q  �R  � k    ;�� ��� Z    ���O�N� B     ��� o     �M�M 0 x  � m    �L�L  � R    �K��
�K .ascrerr ****      � ****� m   
 �� ��� 8 I n v a l i d   n u m b e r   ( m u s t   b e   > 0 ) .� �J��I
�J 
errn� m    	�H�H�Y�I  �O  �N  � ��� r    &��� I      �G��F�G 
0 _frexp  � ��E� o    �D�D 0 x  �E  �F  � J      �� ��� o      �C�C 0 x  � ��B� o      �A�A 0 e  �B  � ��� Z   '8���@�� G   ' 2��� A   ' *��� o   ' (�?�? 0 e  � m   ( )�>�>��� ?   - 0��� o   - .�=�= 0 e  � m   . /�<�< � k   5 ��� ��� Z   5 ^���;�� A   5 8��� o   5 6�:�: 0 x  � m   6 7�� ?栞fK�� l  ; N���� k   ; N��    r   ; @ \   ; > o   ; <�9�9 0 e   m   < =�8�8  o      �7�7 0 e    r   A F	 \   A D

 o   A B�6�6 0 x   m   B C ?�      	 o      �5�5 0 z   �4 r   G N [   G L ]   G J m   G H ?�       o   H I�3�3 0 z   m   J K ?�       o      �2�2 0 y  �4  �   (2 ^ 0.5) / 2   � �    ( 2   ^   0 . 5 )   /   2�;  � k   Q ^  r   Q V \   Q T o   Q R�1�1 0 x   m   R S�0�0  o      �/�/ 0 z   �. r   W ^  [   W \!"! ]   W Z#$# m   W X%% ?�      $ o   X Y�-�- 0 x  " m   Z [&& ?�        o      �,�, 0 y  �.  � '(' r   _ d)*) ^   _ b+,+ o   _ `�+�+ 0 z  , o   ` a�*�* 0 y  * o      �)�) 0 x  ( -.- r   e j/0/ ]   e h121 o   e f�(�( 0 x  2 o   f g�'�' 0 x  0 o      �&�& 0 z  . 343 r   k �565 ^   k �787 ]   k x9:9 ]   k n;<; o   k l�%�% 0 x  < o   l m�$�$ 0 z  : l  n w=�#�"= \   n w>?> ]   n u@A@ l  n sB�!� B [   n sCDC ]   n qEFE m   n oGG ��D=�l�F o   o p�� 0 z  D m   q rHH @0b�s{��!  �   A o   s t�� 0 z  ? m   u vII @P	"*?�#  �"  8 l  x �J��J \   x �KLK ]   x �MNM l  x O��O [   x PQP ]   x }RSR l  x {T��T \   x {UVU o   x y�� 0 z  V m   y zWW @A�C�l��  �  S o   { |�� 0 z  Q m   } ~XX @s��*�
�  �  N o    ��� 0 z  L m   � �YY @���?;�  �  6 o      �� 0 z  4 Z[Z r   � �\]\ o   � ��� 0 e  ] o      �� 0 y  [ ^�^ r   � �_`_ [   � �aba [   � �cdc \   � �efe o   � ��� 0 z  f ]   � �ghg o   � ��� 0 y  h m   � �ii ?+�\a�d o   � ��� 0 x  b ]   � �jkj o   � ��� 0 e  k m   � �ll ?�0     ` o      �� 0 z  �  �@  � k   �8mm non Z   � �pq�rp A   � �sts o   � ��
�
 0 x  t m   � �uu ?栞fK�q l  � �vwxv k   � �yy z{z r   � �|}| \   � �~~ o   � ��	�	 0 e   m   � ��� } o      �� 0 e  { ��� r   � ���� \   � ���� ]   � ���� m   � ��� � o   � ��� 0 x  � m   � ��� � o      �� 0 x  �  w   (2 ^ 0.5) / 2   x ���    ( 2   ^   0 . 5 )   /   2�  r r   � ���� \   � ���� o   � ��� 0 x  � m   � �� �  � o      ���� 0 x  o ��� r   � ���� ]   � ���� o   � ����� 0 x  � o   � ����� 0 x  � o      ���� 0 z  � ��� r   ���� ^   ���� ]   � ���� ]   � ���� o   � ����� 0 x  � o   � ����� 0 z  � l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� m   � ��� ?���� o   � ����� 0 x  � m   � ��� ?���?Vd���  ��  � o   � ����� 0 x  � m   � ��� @Һ�i���  ��  � o   � ����� 0 x  � m   � ��� @,�r�>����  ��  � o   � ����� 0 x  � m   � ��� @1�֒K�R��  ��  � o   � ����� 0 x  � m   � ��� @�c}~ݝ��  ��  � l  ������� [   ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� ]   � ���� l  � ������� [   � ���� o   � ����� 0 x  � m   � ��� @&� �����  ��  � o   � ����� 0 x  � m   � ��� @F�,N���  ��  � o   � ����� 0 x  � m   � ��� @T�3�&����  ��  � o   � ����� 0 x  � m   � ��� @Q���^���  ��  � o   � ����� 0 x  � m   � �� @7 
�&5��  ��  � o      ���� 0 y  � ��� Z  ������� >  ��� o  ���� 0 e  � m  ����  � r  ��� \  ��� o  ���� 0 y  � ]  ��� o  ���� 0 e  � m  �� ?+�\a�� o      ���� 0 y  ��  ��  � ��� r  ��� \  ��� o  ���� 0 y  � l ������ ^  ��� o  ���� 0 z  � m  ���� ��  ��  � o      ���� 0 y  � ��� r  $��� [  "��� o   ���� 0 x  � o   !���� 0 y  � o      ���� 0 z  � ���� Z %8������� >  %(��� o  %&���� 0 e  � m  &'����  � r  +4��� [  +2��� o  +,���� 0 z  � ]  ,1��� o  ,-���� 0 e  � m  -0�� ?�0     � o      ���� 0 z  ��  ��  ��  � ���� L  9;   o  9:���� 0 z  ��  �  l     ��������  ��  ��    l     ��������  ��  ��    l     ��������  ��  ��    i  � �	
	 I     ����
�� .Mth:Lognnull���     doub o      ���� 0 x  ��  
 Q      L     I    ������ 	0 _logn   �� c     o    ���� 0 x   m    ��
�� 
nmbr��  ��   R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��
�� 
errn o      ���� 0 enumber eNumber ��
�� 
erob o      ���� 0 efrom eFrom ����
�� 
errt o      ���� 
0 eto eTo��   I    ������ 
0 _error    m     �  l o g n  !  o    ���� 0 etext eText! "#" o    ���� 0 enumber eNumber# $%$ o    ���� 0 efrom eFrom% &��& o    ���� 
0 eto eTo��  ��   '(' l     ��������  ��  ��  ( )*) l     ��������  ��  ��  * +,+ i  � �-.- I     ��/��
�� .Mth:Lo10null���     doub/ o      ���� 0 x  ��  . Q     $0120 l   3453 L    66 ^    787 ]    9:9 l   ;����; ^    <=< I    ��>���� 	0 _logn  > ?��? c    @A@ o    ���� 0 x  A m    ��
�� 
nmbr��  ��  = m    BB @k���T���  ��  : m    CC @r�     8 m    DD @r�    j4   correct for minor drift   5 �EE 0   c o r r e c t   f o r   m i n o r   d r i f t1 R      �FG
� .ascrerr ****      � ****F o      �� 0 etext eTextG �HI
� 
errnH o      �� 0 enumber eNumberI �JK
� 
erobJ o      �� 0 efrom eFromK �L�
� 
errtL o      �� 
0 eto eTo�  2 I    $�M�� 
0 _error  M NON m    PP �QQ 
 l o g 1 0O RSR o    �� 0 etext eTextS TUT o    �� 0 enumber eNumberU VWV o    �� 0 efrom eFromW X�X o     �� 
0 eto eTo�  �  , YZY l     ��~�}�  �~  �}  Z [\[ l     �|�{�z�|  �{  �z  \ ]^] i  � �_`_ I     �yab
�y .Mth:Logbnull���     douba o      �x�x 0 x  b �wc�v
�w 
Basec o      �u�u 0 b  �v  ` Q     'defd L    gg ^    hih I    �tj�s�t 	0 _logn  j k�rk c    lml o    �q�q 0 x  m m    �p
�p 
nmbr�r  �s  i l   n�o�nn I    �mo�l�m 	0 _logn  o p�kp c    qrq o    �j�j 0 b  r m    �i
�i 
nmbr�k  �l  �o  �n  e R      �hst
�h .ascrerr ****      � ****s o      �g�g 0 etext eTextt �fuv
�f 
errnu o      �e�e 0 enumber eNumberv �dwx
�d 
erobw o      �c�c 0 efrom eFromx �by�a
�b 
errty o      �`�` 
0 eto eTo�a  f I    '�_z�^�_ 
0 _error  z {|{ m    }} �~~  l o g b| � o     �]�] 0 etext eText� ��� o     !�\�\ 0 enumber eNumber� ��� o   ! "�[�[ 0 efrom eFrom� ��Z� o   " #�Y�Y 
0 eto eTo�Z  �^  ^ ��� l     �X�W�V�X  �W  �V  � ��U� l     �T�S�R�T  �S  �R  �U       &�Q���� h r��������������������������������Q  � $�P�O�N�M�L�K�J�I�H�G�F�E�D�C�B�A�@�?�>�=�<�;�:�9�8�7�6�5�4�3�2�1�0�/�.�-
�P 
pimr�O 0 _support  �N 
0 _error  �M 	0 __e__  �L 0 _isequaldelta _isEqualDelta�K (0 _asintegerproperty _asIntegerProperty�J ,0 _makenumberformatter _makeNumberFormatter�I "0 _setbasicformat _setBasicFormat�H  0 _nameforformat _nameForFormat
�G .Mth:FNumnull���     nmbr
�F .Mth:PNumnull���     ctxt
�E .Mth:NuHenull���     ****
�D .Mth:HeNunull���     ctxt
�C .Mth:DeRanull���     doub
�B .Mth:RaDenull���     doub
�A .Mth:Abs_null���     nmbr
�@ .Mth:CmpNnull���     ****
�? .Mth:MinNnull���     ****
�> .Mth:MaxNnull���     ****
�= .Mth:RouNnull���     nmbr�< 0 _sin  
�; .Mth:Sin_null���     doub
�: .Mth:Cos_null���     doub
�9 .Mth:Tan_null���     doub�8 	0 _asin  
�7 .Mth:Sinanull���     doub
�6 .Mth:Cosanull���     doub
�5 .Mth:Tananull���     doub
�4 .Mth:Sinhnull���     doub
�3 .Mth:Coshnull���     doub
�2 .Mth:Tanhnull���     doub�1 
0 _frexp  �0 	0 _logn  
�/ .Mth:Lognnull���     doub
�. .Mth:Lo10null���     doub
�- .Mth:Logbnull���     doub� �,��, �  ��� �+��*
�+ 
cobj� ��   �) 
�) 
frmk�*  � �(��'
�( 
cobj� ��   �&
�& 
osax�'  � ��   �% /
�% 
scpt� �$ 7�#�"���!�$ 
0 _error  �# � ��  �  ������ 0 handlername handlerName� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo�"  � ������ 0 handlername handlerName� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo�  G��� � &0 throwcommanderror throwCommandError�! b  ࠡ����+ � � ������� (0 _asintegerproperty _asIntegerProperty� ��� �  ���� 0 thevalue theValue� 0 propertyname propertyName� 0 minvalue minValue�  � ��
�	�� 0 thevalue theValue�
 0 propertyname propertyName�	 0 minvalue minValue� 0 n  � 	������� � �
� 
long
� 
doub
� 
bool
� 
errn��Y�  � �� ��
� 
errn� �Y��  � 9 (��&E�O���&
 ���& )��lhY hO�W X  )��l�%�%� �� ����������� ,0 _makenumberformatter _makeNumberFormatter�� ����� �  �������� 0 formatstyle formatStyle�� 0 
localecode 
localeCode�� 0 defaultstyle defaultStyle��  � ���������������� 0 formatstyle formatStyle�� 0 
localecode 
localeCode�� 0 defaultstyle defaultStyle�� 0 asocformatter asocFormatter�� 0 formatrecord formatRecord�� 0 s  �� 0 etext eText� F��������������������������������������������+����A��Z����x������������������������������������������������W�g�t������
�� misccura�� &0 nsnumberformatter NSNumberFormatter�� 	0 alloc  �� 0 init  
�� 
kocl
�� 
reco
�� .corecnte****       ****
�� 
pcls
�� 
MthR
�� 
MthA�� 0 requiredvalue RequiredValue
�� 
MthB
�� 
msng
�� 
MthC
�� 
MthD
�� 
MthE
�� 
MthF
�� 
MthG
�� 
MthH�� �� 60 asoptionalrecordparameter asOptionalRecordParameter�� "0 _setbasicformat _setBasicFormat�� (0 _asintegerproperty _asIntegerProperty�� 60 setminimumfractiondigits_ setMinimumFractionDigits_�� 60 setmaximumfractiondigits_ setMaximumFractionDigits_�� <0 setminimumsignificantdigits_ setMinimumSignificantDigits_�� 60 setusessignificantdigits_ setUsesSignificantDigits_�� <0 setmaximumsignificantdigits_ setMaximumSignificantDigits_
�� 
ctxt
�� 
leng
�� 
errn���Y�� ,0 setdecimalseparator_ setDecimalSeparator_��  � ���
� 
errn��\�  �� 60 setusesgroupingseparator_ setUsesGroupingSeparator_�� .0 setgroupingseparator_ setGroupingSeparator_
�� MRndRNhE�� @0 nsnumberformatterroundhalfeven NSNumberFormatterRoundHalfEven�� $0 setroundingmode_ setRoundingMode_
�� MRndRNhT�� @0 nsnumberformatterroundhalfdown NSNumberFormatterRoundHalfDown
�� MRndRNhF�� <0 nsnumberformatterroundhalfup NSNumberFormatterRoundHalfUp
�� MRndRN_T�� 80 nsnumberformatterrounddown NSNumberFormatterRoundDown
�� MRndRN_F�� 40 nsnumberformatterroundup NSNumberFormatterRoundUp
�� MRndRN_U� >0 nsnumberformatterroundceiling NSNumberFormatterRoundCeiling
� MRndRN_D� :0 nsnumberformatterroundfloor NSNumberFormatterRoundFloor� ���
� 
errn��Y�  � 0 etext eText
� 
enum� � .0 throwinvalidparameter throwInvalidParameter� *0 asnslocaleparameter asNSLocaleParameter� 0 
setlocale_ 
setLocale_�����,j+ j+ E�O^�kv��l k 4b  ����b  �,��������a �a �a �a a m+ E�O*���,�m+ O��,� �*��,a jm+ k+ Y hO��,� �*��,a jm+ k+ Y hO��,� �*��,a jm+ k+ O�ek+ Y hO��,� �*��,a jm+ k+  O�ek+ Y hO�a ,� G 0�a ,a !&E�O�a ",j  )a #a $lhY hO��k+ %W X & ')a #a $la (Y hO�a ,� H 1�a ,a !&E�O�a ",j  �fk+ )Y �ek+ )O��k+ *W X & ')a #a $la +Y hO�a ,� ��a ,a ,  ��a -,k+ .Y ��a ,a /  ��a 0,k+ .Y ��a ,a 1  ��a 2,k+ .Y r�a ,a 3  ��a 4,k+ .Y Y�a ,a 5  ��a 6,k+ .Y @�a ,a 7  ��a 8,k+ .Y '�a ,a 9  ��a :,k+ .Y )a #a $la ;Y hY  *���m+ W X & <)ja =W X > <b  �a ?�a @lv�a A+ BO�b  �a Cl+ Dk+ EO�� �������� "0 _setbasicformat _setBasicFormat� ��� �  ���� 0 asocformatter asocFormatter� 0 
formatname 
formatName� 0 defaultstyle defaultStyle�  � ���� 0 asocformatter asocFormatter� 0 
formatname 
formatName� 0 defaultstyle defaultStyle� �������������������������
� MthZMth0� "0 setnumberstyle_ setNumberStyle_
� MthZMth3
� misccura� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle
� MthZMth1� 40 nsnumberformatternostyle NSNumberFormatterNoStyle
� MthZMth2� >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyle
� MthZMth5� @0 nsnumberformattercurrencystyle NSNumberFormatterCurrencyStyle
� MthZMth4� >0 nsnumberformatterpercentstyle NSNumberFormatterPercentStyle
� MthZMth6� @0 nsnumberformatterspelloutstyle NSNumberFormatterSpellOutStyle
� 
kocl
� 
ctxt
� .corecnte****       ****� 0 
setformat_ 
setFormat_
� 
errn��Y
� 
erob
� 
errt
� 
enum� � ���  ��k+ Y ���  ���,k+ Y ���  ���,k+ Y w��  ���,k+ Y f��  ���,k+ Y U��  ���,k+ Y D��  ���,k+ Y 3�kv�a l j ��k+ Y )a a a �a a a a � �,������  0 _nameforformat _nameForFormat� ��� �  �� 0 formatstyle formatStyle�  � �� 0 formatstyle formatStyle� �9�B�K�T�]�eln
� MthZMth1
� MthZMth2
� MthZMth5
� MthZMth4
� MthZMth3
� MthZMth6� I��  �Y ?��  �Y 4��  �Y )��  �Y ��  �Y ��  �Y �%�%� ��~�}���|
� .Mth:FNumnull���     nmbr�~ 0 	thenumber 	theNumber�} �{��
�{ 
Usin� {�z�y�x�z 0 formatstyle formatStyle�y  
�x MthZMth0� �w��v
�w 
Loca� {�u�t�s�u 0 
localecode 
localeCode�t  
�s 
msng�v  � �r�q�p�o�n�m�l�k�j�i�h�r 0 	thenumber 	theNumber�q 0 formatstyle formatStyle�p 0 
localecode 
localeCode�o 0 asocformatter asocFormatter�n 0 defaultstyle defaultStyle�m 0 defaultformat defaultFormat�l 0 
asocstring 
asocString�k 0 etext eText�j 0 enumber eNumber�i 0 efrom eFrom�h 
0 eto eTo� "�g�f�e���d�c�b�a�`�_�^�]�\�[�Z�Y�X�W�V�U�T�S�R�Q�P�O�N�M� �L�K
�g 
kocl
�f 
nmbr
�e .corecnte****       ****�d �c 60 throwinvalidparametertype throwInvalidParameterType
�b MthZMth0
�a 
msng
�` 
bool
�_ misccura�^ &0 nsnumberformatter NSNumberFormatter�] 	0 alloc  �\ 0 init  �[ 0 nslocale NSLocale�Z 0 systemlocale systemLocale�Y 0 
setlocale_ 
setLocale_
�X 
pcls
�W 
long�V 40 nsnumberformatternostyle NSNumberFormatterNoStyle�U "0 setnumberstyle_ setNumberStyle_�T D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle�S ,0 _makenumberformatter _makeNumberFormatter�R &0 stringfromnumber_ stringFromNumber_
�Q 
errn�P�Y
�O 
erob
�N 
ctxt�M 0 etext eText� �J�I�
�J 
errn�I 0 enumber eNumber� �H�G�
�H 
erob�G 0 efrom eFrom� �F�E�D
�F 
errt�E 
0 eto eTo�D  �L �K 
0 _error  �| � ��kv��l j  b  �����+ Y hO�� 	 �� �& C��,j+ j+ E�O���,j+ k+ O�a ,a   ��a ,k+ Y ��a ,k+ Y �a ,E�O*���m+ E�O��k+ E�O��  )a a a ��a Y hO�a &W X  *a ����a  + !� �C0�B�A���@
�C .Mth:PNumnull���     ctxt�B 0 thetext theText�A �?��
�? 
Usin� {�>�=�<�> 0 formatstyle formatStyle�=  
�< MthZMth0� �;��:
�; 
Loca� {�9�8�7�9 0 
localecode 
localeCode�8  
�7 
msng�:  � 
�6�5�4�3�2�1�0�/�.�-�6 0 thetext theText�5 0 formatstyle formatStyle�4 0 
localecode 
localeCode�3 0 asocformatter asocFormatter�2 0 
asocnumber 
asocNumber�1 $0 localeidentifier localeIdentifier�0 0 etext eText�/ 0 enumber eNumber�. 0 efrom eFrom�- 
0 eto eTo� (�,�+�*V[�)�(�'�&�%�$�#�"�!� �������������������������
�, 
kocl
�+ 
ctxt
�* .corecnte****       ****�) �( 60 throwinvalidparametertype throwInvalidParameterType
�' MthZMth0
�& 
msng
�% 
bool
�$ misccura�# &0 nsnumberformatter NSNumberFormatter�" 	0 alloc  �! 0 init  �  0 nslocale NSLocale� 0 systemlocale systemLocale� 0 
setlocale_ 
setLocale_� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle� "0 setnumberstyle_ setNumberStyle_� ,0 _makenumberformatter _makeNumberFormatter� &0 numberfromstring_ numberFromString_� 
0 locale  � $0 localeidentifier localeIdentifier
� 
leng
� 
errn��Y
� 
erob�  0 _nameforformat _nameForFormat
� 
****� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� �
�	�
�
 
errt�	 
0 eto eTo�  � � 
0 _error  �@ � ͠kv��l j  b  �����+ Y hO�� 	 �� �& *��,j+ j+ E�O���,j+ k+ O��a ,k+ Y *��fm+ E�O��k+ E�O��  R�j+ j+ �&E�O�a ,j  
a E�Y a �%a %E�O)a a a ��a *�k+ %a  %�%a !%Y hO�a "&W X # $*a %����a &+ '� ������
� .Mth:NuHenull���     ****� 0 	thenumber 	theNumber� ���
� 
Plac� {��� � 0 	chunksize 	chunkSize�  �   � �����
�� 
Pref� {�������� 0 	hasprefix 	hasPrefix��  
�� boovfals��  � ������������������������������ 0 	thenumber 	theNumber�� 0 	chunksize 	chunkSize�� 0 	hasprefix 	hasPrefix�� 0 hextext hexText�� 0 	hexprefix 	hexPrefix�� 0 padtext padText�� 0 maxsize maxSize�� 0 
resultlist 
resultList�� 0 aref aRef�� 0 oldtids oldTIDs�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� >��-��������M������f��k����q�����������������5:DW��[������������������������������������� (0 asintegerparameter asIntegerParameter�� (0 asbooleanparameter asBooleanParameter
�� 
kocl
�� 
list
�� .corecnte****       ****�� 00 aswholenumberparameter asWholeNumberParameter�� 
�� 
bool
�� 
long�� �� .0 throwinvalidparameter throwInvalidParameter������ 
�� 
cobj
�� 
leng�� 0 
resultlist 
resultList� �����������
�� .ascrinit****      � ****� k     	�� [����  ��  ��  � ���� 
0 _list_  � ����
�� 
cobj�� 
0 _list_  �� 
b   �-E��� 
0 _list_  
�� 
pcnt
�� 
doub
�� 
errn���\��  � ������
�� 
errn���\��  
�� 
ctxt
�� 
ascr
�� 
txdl�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� �����
�� 
errt�� 
0 eto eTo�  �� �� 
0 _error  ���b  ��l+ E�Ob  ��l+ E�O�kv��l j b  ��l+ E�O�j
 ���& b  �����+ Y hOa E�O�j I�j	 �a �$�& (b  �a �a a �$%a %a �$k%�+ Y hOa E�O�'E�Y Ca E�O�j	 �a �$k�& (b  �a �a a �$%a %a �$k%�+ Y hO� �a %E�Y hO &h�ja a �a #k/�%E�O�a "E�[OY��O h�a ,�a �%E�[OY��O��%Y{�k
 ���& b  �a  �a !�+ Y hOa "a �$klvE[a k/E�Z[a l/E�ZO �kh�a #%E�[OY��Oa $a %K &S�O ӧa ',[�a l kh  ;�a (,�&E�O��a (,a )&
 �j�&
 ���& )a *a +lhY hW :X , -�� b  �a .�a /a �$k%�+ Y b  �a 0�a 1�+ Oa 2E�O &h�ja 3a �a #k/�%E�O�a "E�[OY��O��%[a 4\[Z�'\Zi2�a (,F[OY�AO_ 5a 6,E�Oa 7_ 5a 6,FO� a 8�a ',%E�Y �a ',a 4&E�O�_ 5a 6,FO�W X 9 :*a ;����a <+ =� �&�����
� .Mth:HeNunull���     ctxt� 0 hextext hexText� ���
� 
Plac� {���� 0 	chunksize 	chunkSize�  �  � ���
� 
Prec� {���� 0 	isprecise 	isPrecise�  
� boovtrue�  � ������������� 0 hextext hexText� 0 	chunksize 	chunkSize� 0 	isprecise 	isPrecise� 0 	thenumber 	theNumber� 0 
isnegative 
isNegative� 0 charref charRef� 0 i  � 0 
resultlist 
resultList� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� 267C�O���b�g��t������������������������7An������� "0 astextparameter asTextParameter� (0 asintegerparameter asIntegerParameter� 
� 
bool
� 
long� � .0 throwinvalidparameter throwInvalidParameter� (0 asbooleanparameter asBooleanParameter
� 
ctxt
� 
kocl
� 
cobj
� .corecnte****       ****� 
� misccura
� 
psof
� 
psin
� .sysooffslong    ��� null
� 
errn��@�  � ���
� 
errn��@�  ��Y
� 
erob
� 
leng� 0 
resultlist 
resultList� �������
� .ascrinit****      � ****� k     �� ��  �  �  � �� 
0 _list_  � �� 
0 _list_  � jv�� 
0 _list_  � 0 etext eText� ��~�
� 
errn�~ 0 enumber eNumber� �}�|�
�} 
erob�| 0 efrom eFrom� �{�z�y
�{ 
errt�z 
0 eto eTo�y  � � 
0 _error  �cN��Fb  ��l+ E�Ob  ��l+ E�O�j
 ���& b  �����+ Y hOb  ��l+ E�O�j  � �jE�O��E�O� �[a \[Zl\Zi2E�Y hO�a  �[a \[Zm\Zi2E�Y hO U�[a a l kh �a  E�Oa  *a �a a � UE�O�j  )a a lhY hO��kE�[OY��W X  )a a a  ��a !O�	 	��k �& )a a a  ��a "Y hO� 	�'E�Y hO�Y�a #,�#j )a a a  ��a $�%a %%Y hOa &a 'K (S�O �k�a #,E�h jE�O |�[a \[Z�\Z��k2[a a l kh �a  E�Oa  *a �a a )� UE�O�j  &)a a a  �[a \[Z�\Z��k2�a *Y hO��kE�[OY��O�	 	��k �& &)a a a  �[a \[Z�\Z��k2�a +Y hO��a ,,6F[OY�<O�a ,,EVW X - .*a /����a 0+ 1� �x��w�v���u
�x .Mth:DeRanull���     doub�w 0 x  �v  � �t�s�r�q�p�t 0 x  �s 0 etext eText�r 0 enumber eNumber�q 0 efrom eFrom�p 
0 eto eTo� �o�n�m�l���k�j
�o 
doub
�n 
pi  �m ��l 0 etext eText� �i�h�
�i 
errn�h 0 enumber eNumber� �g�f�
�g 
erob�f 0 efrom eFrom� �e�d�c
�e 
errt�d 
0 eto eTo�c  �k �j 
0 _error  �u  ��&��! W X  *塢���+ � �b��a�`���_
�b .Mth:RaDenull���     doub�a 0 x  �`  � �^�]�\�[�Z�^ 0 x  �] 0 etext eText�\ 0 enumber eNumber�[ 0 efrom eFrom�Z 
0 eto eTo� �Y�X�W�V���U�T
�Y 
doub
�X 
pi  �W ��V 0 etext eText� �S�R�
�S 
errn�R 0 enumber eNumber� �Q�P�
�Q 
erob�P 0 efrom eFrom� �O�N�M
�O 
errt�N 
0 eto eTo�M  �U �T 
0 _error  �_  ��&��!!W X  *塢���+ � �L	�K�J���I
�L .Mth:Abs_null���     nmbr�K 0 x  �J  � �H�G�F�E�D�H 0 x  �G 0 etext eText�F 0 enumber eNumber�E 0 efrom eFrom�D 
0 eto eTo� �C�B�	'�A�@
�C 
nmbr�B 0 etext eText� �?�>�
�? 
errn�> 0 enumber eNumber� �=�< 
�= 
erob�< 0 efrom eFrom  �;�:�9
�; 
errt�: 
0 eto eTo�9  �A �@ 
0 _error  �I * ��&E�O�j �'Y �W X  *㡢���+ � �8	7�7�6�5
�8 .Mth:CmpNnull���     ****�7 �4�4   �3�2�3 0 n1  �2 0 n2  �6   	�1�0�/�.�-�,�+�*�)�1 0 n1  �0 0 n2  �/ 0 dn  �. 0 dm  �- 0 d  �, 0 etext eText�+ 0 enumber eNumber�* 0 efrom eFrom�) 
0 eto eTo �(�'�&�%�$�#�"	��!� 
�( 
kocl
�' 
long
�& .corecnte****       ****
�% 
doub
�$ 
cobj
�# 
bool�" 0 etext eText ��
� 
errn� 0 enumber eNumber ��
� 
erob� 0 efrom eFrom ���
� 
errt� 
0 eto eTo�  �! �  
0 _error  �5 � ���lv��l l  ��  jY hY s��&��&lvE[�k/E�Z[�l/E�ZO�j  b  � E�Y b  � E�O�'E�O�� ��lvE[�k/E�Z[�l/E�ZY hO��E�O��	 ���& jY hO�� iY kW X  *襦���+ 
� �	����
� .Mth:MinNnull���     ****� 0 thelist theList�   	���������� 0 thelist theList� 0 
listobject 
listObject� 0 	theresult 	theResult� 0 aref aRef� 0 x  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo �	�	�
�	�����
	���� 0 
listobject 
listObject	 �� ����
� .ascrinit****      � **** k      	�����  �   ��   ���� 
0 _list_   ������ "0 aslistparameter asListParameter�� 
0 _list_  �� b  b   k+  ��
 
0 _list_  
�	 
cobj
� 
nmbr
� 
kocl
� .corecnte****       ****
� 
pcnt� 0 etext eText
 ����
�� 
errn�� 0 enumber eNumber ����
�� 
erob�� 0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  � � 
0 _error  � X G��K S�O��,�k/�&E�O +��,[��l kh ��,�&E�O�� �E�Y h[OY��O�W X 	 
*륦���+ � ��
������
�� .Mth:MaxNnull���     ****�� 0 thelist theList��   	�������������������� 0 thelist theList�� 0 
listobject 
listObject�� 0 	theresult 	theResult�� 0 aref aRef�� 0 x  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo ��
��������������
D������ 0 
listobject 
listObject ��������
�� .ascrinit****      � **** k      
����  ��  ��   ���� 
0 _list_   ������ "0 aslistparameter asListParameter�� 
0 _list_  �� b  b   k+  ��� 
0 _list_  
�� 
cobj
�� 
nmbr
�� 
kocl
�� .corecnte****       ****
�� 
pcnt�� 0 etext eText ����
�� 
errn�� 0 enumber eNumber ����
�� 
erob�� 0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� X G��K S�O��,�k/�&E�O +��,[��l kh ��,�&E�O�� �E�Y h[OY��O�W X 	 
*륦���+ � ��
T������
�� .Mth:RouNnull���     nmbr�� 0 num  �� ��
�� 
Plac {�������� 0 decimalplaces decimalPlaces��  ��   ����
�� 
Dire {�������� &0 roundingdirection roundingDirection��  
�� MRndRNhE��   ��������� 0 num  � 0 decimalplaces decimalPlaces� &0 roundingdirection roundingDirection� 0 themultiplier theMultiplier� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo 
n�
z���
�
�
��
���������� ���� "0 asrealparameter asRealParameter� (0 asintegerparameter asIntegerParameter� 

� MRndRNhE
� MRndRNhT
� MRndRNhF
� MRndRN_T
� MRndRN_F
� MRndRN_U
� 
bool
� MRndRN_D� >0 throwinvalidconstantparameter throwInvalidConstantParameter� 0 etext eText  ��!
� 
errn� 0 enumber eNumber! ��"
� 
erob� 0 efrom eFrom" ���
� 
errt� 
0 eto eTo�  � � 
0 _error  ����b  ��l+ E�Ob  ��l+ E�O�j �$E�O�� � �!E�Y hO��  3��lv�l!k#kv 
�k"E�Y �j ��k"E�Y 	��k"E�Y��  1��lv�k#kv 
�k"E�Y �j ��k"E�Y 	��k"E�Y ��  C��lv�k#kv �j �k"kE�Y 	�k"kE�Y �j ��k"E�Y 	��k"E�Y ���  
�k"E�Y ���  ,�k#j  
�k"E�Y �j �k"kE�Y 	�k"kE�Y a��  $�j
 	�k#j �& 
�k"E�Y 	�k"kE�Y 9�a   $�j
 	�k#j �& 
�k"E�Y 	�k"kE�Y b  �a l+ O�j  	�k"Y �j 	��"Y ��!W X  *a ����a + � ���#$�� 0 _sin  � �%� %  �� 0 x  �  # ������� 0 x  � 0 isneg isNeg� 0 y  � 0 z  � 0 z2  � 0 zz  $ ����?��y|���������������h
� 
pi  � �� � � 
� 
bool� ��#��! E�O�jE�O� 	�'E�Y hO���! k"E�O��� k"� E�O�l#k  �kE�O�kE�Y hO��#E�O�m �E�O��E�Y hO��� �� �� E�O�� E�O�k 
 �l �& *�l!�� � �� �� �� a � a  E�Y +��� a � a � a � a � a � a  E�O� 	�'E�Y hO�� ����&'�
� .Mth:Sin_null���     doub� 0 x  �  & ������ 0 x  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo' ���(
��
� 
nmbr� 0 _sin  � 0 etext eText( ��)
� 
errn� 0 enumber eNumber) �~�}*
�~ 
erob�} 0 efrom eFrom* �|�{�z
�| 
errt�{ 
0 eto eTo�z  � � 
0 _error  �  *��&k+ W X  *䡢���+ � �y�x�w+,�v
�y .Mth:Cos_null���     doub�x 0 x  �w  + �u�t�s�r�q�u 0 x  �t 0 etext eText�s 0 enumber eNumber�r 0 efrom eFrom�q 
0 eto eTo, �p�o�n�m-1�l�k
�p 
nmbr�o Z�n 0 _sin  �m 0 etext eText- �j�i.
�j 
errn�i 0 enumber eNumber. �h�g/
�h 
erob�g 0 efrom eFrom/ �f�e�d
�f 
errt�e 
0 eto eTo�d  �l �k 
0 _error  �v ! *��&�k+ W X  *塢���+ � �cA�b�a01�`
�c .Mth:Tan_null���     doub�b 0 x  �a  0 
�_�^�]�\�[�Z�Y�X�W�V�_ 0 x  �^ 0 isneg isNeg�] 0 y  �\ 0 z  �[ 0 z2  �Z 0 zz  �Y 0 etext eText�X 0 enumber eNumber�W 0 efrom eFrom�V 
0 eto eTo1 �U�T�S�R�Q�P�O�Nc�M�L�K��J������� �I�H2'�G�F
�U 
nmbr�T Z�S
�R 
bool
�Q 
errn�P�s
�O 
erob�N �Mh
�L 
pi  �K ��J �I �H 0 etext eText2 �E�D3
�E 
errn�D 0 enumber eNumber3 �C�B4
�C 
erob�B 0 efrom eFrom4 �A�@�?
�A 
errt�@ 
0 eto eTo�?  �G �F 
0 _error  �` ��&E�O�� 
 �� �& )�����Y hO��#��! E�O�jE�O� 	�'E�Y hO���!!k"E�O��� k"� E�O�l#k  �kE�O�kE�Y hO��� �� �a  E�O�� E�O�a  4��� a � a � a  �a � a � a � a !E�Y �E�O�l 
 	�a  �& 
i�!E�Y hO� 	�'E�Y hO�W X  *a ����a + � �>C�=�<56�;�> 	0 _asin  �= �:7�: 7  �9�9 0 x  �<  5 �8�7�6�5�4�8 0 x  �7 0 isneg isNeg�6 0 zz  �5 0 p  �4 0 z  6 �3�2�1�0\i�����������/�� !"�.
�3 
errn�2�Y
�1 
erob�0 
�/ 
pi  �. ��; ��jE�O� 	�'E�Y hO�k )�����Y hO�� Xk�E�O�� �� �� �� � ��� �� �� �!E�O���$E�O_ �!�E�O�� a E�O��_ �!E�Y ]�a  �E�Y O�� E�O�a � a � a � a � a � a  �a � a � a � a � a !� �E�O� 	�'E�Y hO�_ a !!� �-:�,�+89�*
�- .Mth:Sinanull���     doub�, 0 x  �+  8 �)�(�'�&�%�) 0 x  �( 0 etext eText�' 0 enumber eNumber�& 0 efrom eFrom�% 
0 eto eTo9 �$�#�":N�!� 
�$ 
nmbr�# 	0 _asin  �" 0 etext eText: ��;
� 
errn� 0 enumber eNumber; ��<
� 
erob� 0 efrom eFrom< ���
� 
errt� 
0 eto eTo�  �! �  
0 _error  �*  *��&k+ W X  *䡢���+ � �^��=>�
� .Mth:Cosanull���     doub� 0 x  �  = ������ 0 x  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo> ����?u��
� Z
� 
nmbr� 	0 _asin  � 0 etext eText? �	�@
�	 
errn� 0 enumber eNumber@ ��A
� 
erob� 0 efrom eFromA ���
� 
errt� 
0 eto eTo�  � �
 
0 _error  � ! �*��&k+ W X  *塢���+ � ���� BC��
� .Mth:Tananull���     doub� 0 x  �   B ������������ 0 x  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eToC �������D�����
�� 
nmbr�� 	0 _asin  �� 0 etext eTextD ����E
�� 
errn�� 0 enumber eNumberE ����F
�� 
erob�� 0 efrom eFromF ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� + ��&E�O*��� k�$!k+ W X  *塢���+ � �������GH��
�� .Mth:Sinhnull���     doub�� 0 x  ��  G ������������ 0 x  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eToH �����I�����
�� 
nmbr�� 0 etext eTextI ����J
�� 
errn�� 0 enumber eNumberJ ����K
�� 
erob�� 0 efrom eFromK ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� / ��&E�O�b  �$b  �'$ W X  *䡢���+ � �������LM��
�� .Mth:Coshnull���     doub�� 0 x  ��  L ������������ 0 x  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eToM ��	��N����
�� 
nmbr�� 0 etext eTextN ����O
�� 
errn�� 0 enumber eNumberO ����P
�� 
erob�� 0 efrom eFromP ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� / ��&E�O�b  �$b  �'$ W X  *䡢���+ � ��,����QR��
�� .Mth:Tanhnull���     doub�� 0 x  ��  Q ��������� 0 x  �� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eToR ��SV��
� 
nmbr� 0 etext eTextS ��T
� 
errn� 0 enumber eNumberT ��U
� 
erob� 0 efrom eFromU ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �� > -��&E�Ob  �$b  �'$b  �$b  �'$!W X  *㡢���+ � �r��VW�� 
0 _frexp  � �X� X  �� 0 m  �  V ���� 0 m  � 0 isneg isNeg� 0 e  W ���
� 
bool� o�j  
�jlvY hO�jE�O� 	�'E�Y hOjE�O 3h��	 �k�&�k �l!E�O�kE�Y �l E�O�kE�[OY��O� 	�'E�Y hO��lv� ����YZ�� 	0 _logn  � �[� [  �� 0 x  �  Y ����� 0 x  � 0 e  � 0 z  � 0 y  Z ��������GHIWXYil�����������
� 
errn��Y� 
0 _frexp  
� 
cobj���
� 
bool�<�j )��l�Y hO*�k+ E[�k/E�Z[�l/E�ZO��
 �l�& j�� �kE�O��E�O� �E�Y �kE�O� �E�O��!E�O�� E�O�� � �� � ��� �� �!E�O�E�O��� ��a  E�Y ��� �kE�Ol� kE�Y �kE�O�� E�O�� a � a � a � a � a � a  �a � a � a � a � a !E�O�j ��� E�Y hO��l!E�O��E�O�j ��a  E�Y hO�� �
��\]�
� .Mth:Lognnull���     doub� 0 x  �  \ ������� 0 x  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom�� 
0 eto eTo] ������^����
�� 
nmbr�� 	0 _logn  �� 0 etext eText^ ����_
�� 
errn�� 0 enumber eNumber_ ����`
�� 
erob�� 0 efrom eFrom` ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �  *��&k+ W X  *䡢���+ � ��.����ab�
�� .Mth:Lo10null���     doub�� 0 x  ��  a �~�}�|�{�z�~ 0 x  �} 0 etext eText�| 0 enumber eNumber�{ 0 efrom eFrom�z 
0 eto eTob 
�y�xBCD�wcP�v�u
�y 
nmbr�x 	0 _logn  �w 0 etext eTextc �t�sd
�t 
errn�s 0 enumber eNumberd �r�qe
�r 
erob�q 0 efrom eFrome �p�o�n
�p 
errt�o 
0 eto eTo�n  �v �u 
0 _error  � % *��&k+ �!� �!W X  *硢���+ 	� �m`�l�kfg�j
�m .Mth:Logbnull���     doub�l 0 x  �k �i�h�g
�i 
Base�h 0 b  �g  f �f�e�d�c�b�a�f 0 x  �e 0 b  �d 0 etext eText�c 0 enumber eNumber�b 0 efrom eFrom�a 
0 eto eTog �`�_�^h}�]�\
�` 
nmbr�_ 	0 _logn  �^ 0 etext eTexth �[�Zi
�[ 
errn�Z 0 enumber eNumberi �Y�Xj
�Y 
erob�X 0 efrom eFromj �W�V�U
�W 
errt�V 
0 eto eTo�U  �] �\ 
0 _error  �j ( *��&k+ *��&k+ !W X  *䢣���+  ascr  ��ޭ