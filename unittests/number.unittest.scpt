FasdUAS 1.101.10   ��   ��    k             x     �� ����    4    "�� 
�� 
scpt  m     ! 	 	 � 
 
  T e s t T o o l s��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l          x    $�� ����    4   ' +�� 
�� 
scpt  m   ) *   �    N u m b e r��      the script being tested     �   0   t h e   s c r i p t   b e i n g   t e s t e d      l     ��������  ��  ��        l     ��������  ��  ��        h   $ +��  �� 0 suite_round suite_Round   k       ! !  " # " l     ��������  ��  ��   #  $ % $ i     & ' & I      ��������  0 test_rounddate test_roundDate��  ��   ' I    - (�� ) ( z�� 
�� .���:AsRenull��� ��� null��   ) �� * +
�� 
Valu * l  	  ,���� , I  	  - . / - z�� 
�� .Mth:RouNnull���     nmbr . m     0 0 @�z�G� / �� 1��
�� 
Plac 1 m    ���� ��  ��  ��   + �� 2 3
�� 
Equa 2 m     4 4 @�\(� 3 �� 5��
�� 
Usin 5 l   ( 6���� 6 I   ( 7���� 7 z�� 
�� .���:ExEqnull��� ��� null��  ��  ��  ��  ��   %  8�� 8 l      �� 9 :��   9��	to test_square()		assert test result for (0.7 ^ 2) is 0.49 -- TEST: this fails not because code is wrong but because floating point math hardware has limited precision	end test_square		to test_square2()		assert test result for (0.7 ^ 2) is 0.49 using (numeric equality check) -- TEST: this passes as `numeric equality check` allows up to �1.0e-9 difference between numbers	end test_square2	    : � ; ;  	 t o   t e s t _ s q u a r e ( )  	 	 a s s e r t   t e s t   r e s u l t   f o r   ( 0 . 7   ^   2 )   i s   0 . 4 9   - -   T E S T :   t h i s   f a i l s   n o t   b e c a u s e   c o d e   i s   w r o n g   b u t   b e c a u s e   f l o a t i n g   p o i n t   m a t h   h a r d w a r e   h a s   l i m i t e d   p r e c i s i o n  	 e n d   t e s t _ s q u a r e  	  	 t o   t e s t _ s q u a r e 2 ( )  	 	 a s s e r t   t e s t   r e s u l t   f o r   ( 0 . 7   ^   2 )   i s   0 . 4 9   u s i n g   ( n u m e r i c   e q u a l i t y   c h e c k )   - -   T E S T :   t h i s   p a s s e s   a s   ` n u m e r i c   e q u a l i t y   c h e c k `   a l l o w s   u p   t o   � 1 . 0 e - 9   d i f f e r e n c e   b e t w e e n   n u m b e r s  	 e n d   t e s t _ s q u a r e 2  	��     < = < l     ��������  ��  ��   =  > ? > h   , 3�� @�� $0 suite_conversion suite_Conversion @ k       A A  B C B l     ��������  ��  ��   C  D E D i     F G F I      �������� $0 test_parsenumber test_parseNumber��  ��   G k     = H H  I J I I     K�� L K z�� 
�� .���:AsRenull��� ��� null��   L �� M N
�� 
Valu M l  	  O���� O I  	  P Q�� P z�� 
�� .Mth:PNumnull���     ctxt Q m     R R � S S  3 . 1 4��  ��  ��   N �� T��
�� 
Equa T m     U U @	�Q���   J  V�� V I   = W�� X W z�� 
�� .���:AsRenull��� ��� null��   X �� Y Z
�� 
Valu Y l  ' 6 [���� [ I  ' 6 \ ] ^ \ z�� 
�� .Mth:PNumnull���     ctxt ] m   . / _ _ � ` `  3 , 1 4 ^ �� a��
�� 
Loca a m   0 1 b b � c c 
 d e _ D E��  ��  ��   Z �� d��
�� 
Equa d m   7 8 e e @	�Q���  ��   E  f g f l     ��������  ��  ��   g  h i h i    j k j I      �������� &0 test_formatnumber test_formatNumber��  ��   k k     = l l  m n m I     o�� p o z�� 
�� .���:AsRenull��� ��� null��   p �� q r
�� 
Valu q l  	  s���� s I  	  t u�� t z�� 
�� .Mth:FNumnull���     nmbr u m     v v @	�Q���  ��  ��   r �� w��
�� 
Equa w m     x x � y y  3 . 1 4��   n  z�� z I   = {�� | { z�� 
�� .���:AsRenull��� ��� null��   | �� } ~
�� 
Valu } l  ' 6 ����  I  ' 6 � � � � z�� 
�� .Mth:FNumnull���     nmbr � m   . / � � @	�Q� � �� ���
�� 
Loca � m   0 1 � � � � � 
 d e _ D E��  ��  ��   ~ �� ���
�� 
Equa � m   7 8 � � � � �  3 , 1 4��  ��   i  ��� � l     ��������  ��  ��  ��   ?  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � i   4 7 � � � I     ������
�� .aevtoappnull  �   � ****��  ��   � l     � � � � I    �� ���
�� .sysoexecTEXT���     TEXT � b      � � � m      � � � � �  ~ / b i n / o s a t e s t   � n    
 � � � 1    
��
�� 
strq � n     � � � 1    ��
�� 
psxp � l    ����� � I   �� ���
�� .earsffdralis        afdr �  f    ��  ��  ��  ��   � [ U handy for running tests in Script Editor (assumes `osatest` is installed in `~/bin`)    � � � � �   h a n d y   f o r   r u n n i n g   t e s t s   i n   S c r i p t   E d i t o r   ( a s s u m e s   ` o s a t e s t `   i s   i n s t a l l e d   i n   ` ~ / b i n ` ) �  � � � l     ��~�}�  �~  �}   �  ��| � l     �{�z�y�{  �z  �y  �|       �x � � � � ��x   � �w�v�u�t
�w 
pimr�v 0 suite_round suite_Round�u $0 suite_conversion suite_Conversion
�t .aevtoappnull  �   � **** � �s ��s  �   � � � � �r ��q
�r 
cobj �  � �   �p 	
�p 
scpt�q   � �o ��n
�o 
cobj �  � �   �m
�m 
osax�n   � �l ��k
�l 
cobj �  � �   �j 
�j 
scpt�k   � �i     ��i 0 suite_round suite_Round � �h � ��h   � �g�g  0 test_rounddate test_roundDate � �f '�e�d � ��c�f  0 test_rounddate test_roundDate�e  �d   �   � �b 	�a  0�`�_�^ 4�] 	�\�[�Z
�b 
scpt
�a 
Valu
�` 
Plac
�_ .Mth:RouNnull���     nmbr
�^ 
Equa
�] 
Usin
�\ .���:ExEqnull��� ��� null�[ 
�Z .���:AsRenull��� ��� null�c .)��/ '*�)��/ 	��ll U���)��/ *j U� U � �Y @   ��Y $0 suite_conversion suite_Conversion � �X � � ��X   � �W�V�W $0 test_parsenumber test_parseNumber�V &0 test_formatnumber test_formatNumber � �U G�T�S � ��R�U $0 test_parsenumber test_parseNumber�T  �S   �   � �Q 	�P  R�O�N U�M�L 	  _�K b
�Q 
scpt
�P 
Valu
�O .Mth:PNumnull���     ctxt
�N 
Equa�M 
�L .���:AsRenull��� ��� null
�K 
Loca�R >)��/ *�)��/ �j U��� 	UO)��/ *�)��/ 	���l U��� 	U � �J k�I�H � ��G�J &0 test_formatnumber test_formatNumber�I  �H   �   � �F 	�E  v�D�C x�B�A 	 �@ � �
�F 
scpt
�E 
Valu
�D .Mth:FNumnull���     nmbr
�C 
Equa�B 
�A .���:AsRenull��� ��� null
�@ 
Loca�G >)��/ *�)��/ �j U��� 	UO)��/ *�)��/ 	���l U��� 	U � �? ��>�= � ��<
�? .aevtoappnull  �   � ****�>  �=   �   �  ��;�:�9�8
�; .earsffdralis        afdr
�: 
psxp
�9 
strq
�8 .sysoexecTEXT���     TEXT�< �)j �,�,%j  ascr  ��ޭ