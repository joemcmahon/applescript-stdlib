FasdUAS 1.101.10   ��   ��    k             x     �� ����    4   % )�� 
�� 
scpt  m   ' ( 	 	 � 
 
  T e s t L i b��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l          x    $�� ����    4   . 2�� 
�� 
scpt  m   0 1   �    T e x t L i b��      the script being tested     �   0   t h e   s c r i p t   b e i n g   t e s t e d      l     ��������  ��  ��        l     ��������  ��  ��        h   $ +��  �� $0 suite_modifytext suite_ModifyText   k       ! !  " # " l      �� $ %��   $2,	to configure_skipTests()		return "checking suite skipping works" -- skip all tests in this suite		return {test_uppercase:"checking per-test skipping works", test_lowercase:missing value} -- skip 'test_uppercase only'		return missing value -- do all tests in this suite	end configure_skipTests	    % � & &X  	 t o   c o n f i g u r e _ s k i p T e s t s ( )  	 	 r e t u r n   " c h e c k i n g   s u i t e   s k i p p i n g   w o r k s "   - -   s k i p   a l l   t e s t s   i n   t h i s   s u i t e  	 	 r e t u r n   { t e s t _ u p p e r c a s e : " c h e c k i n g   p e r - t e s t   s k i p p i n g   w o r k s " ,   t e s t _ l o w e r c a s e : m i s s i n g   v a l u e }   - -   s k i p   ' t e s t _ u p p e r c a s e   o n l y '  	 	 r e t u r n   m i s s i n g   v a l u e   - -   d o   a l l   t e s t s   i n   t h i s   s u i t e  	 e n d   c o n f i g u r e _ s k i p T e s t s  	 #  ' ( ' i     ) * ) I      �������� 0 test_uppercase  ��  ��   * k     � + +  , - , I    + .�� / . z�� 
�� .���:AsRenull��� ��� null��   / �� 0 1
�� 
Valu 0 l  	  2���� 2 I  	  3 4�� 3 z�� 
�� .Txt:UppTnull���     ctxt 4 m     5 5 � 6 6  f o � b � r��  ��  ��   1 �� 7 8
�� 
Equa 7 m     9 9 � : :  F O � B � R 8 �� ;��
�� 
Usin ; l   & <���� < I   & =���� = z�� 
�� .���:ExEqnull��� ��� null��  ��  ��  ��  ��   -  > ? > I  , O @�� A @ z�� 
�� .���:AsRenull��� ��� null��   A �� B C
�� 
Valu B l  5 B D���� D I  5 B E F�� E z�� 
�� .Txt:UppTnull���     ctxt F m   < = G G @      ��  ��  ��   C �� H��
�� 
Equa H l  C H I���� I c   C H J K J m   C D L L @       K m   D G��
�� 
ctxt��  ��  ��   ?  M�� M X   P � N�� O N I  r � P�� Q P z�� 
�� .���:AsErnull��� ��� null��   Q �� R S
�� 
Args R n   � T U T 1   � ���
�� 
pcnt U o    ����� 0 aref aRef S �� V��
�� 
Equa V K   � � W W �� X���� 0 errornumber errorNumber X m   � ������Y��  ��  �� 0 aref aRef O J   S b Y Y  Z [ Z K   S [ \ \ �� ]���� 0 a   ] m   V Y ^ ^ � _ _  f o o��   [  `�� ` J   [ ` a a  b�� b 1   [ ^��
�� 
ascr��  ��  ��   (  c d c l     ��������  ��  ��   d  e f e i    g h g I      �������� 0 test_lowercase  ��  ��   h k     [ i i  j k j I     l�� m l z�� 
�� .���:AsRenull��� ��� null��   m �� n o
�� 
Valu n l  	  p���� p I  	  q r�� q z�� 
�� .Txt:LowTnull���     ctxt r m     s s � t t  F O � B � R��  ��  ��   o �� u��
�� 
Equa u m     v v � w w  f o � b � r��   k  x�� x X    [ y�� z y I  6 V {�� | { z�� 
�� .���:AsErnull��� ��� null��   | �� } ~
�� 
Args } n  C H  �  1   D H��
�� 
pcnt � o   C D���� 0 aref aRef ~ �� ���
�� 
Equa � K   I Q � � �� ����� 0 errornumber errorNumber � m   L O�����Y��  ��  �� 0 aref aRef z J   ! * � �  � � � K   ! % � � �� ����� 0 a   � m   " # � � � � �  f o o��   �  ��� � J   % ( � �  ��� � 1   % &��
�� 
ascr��  ��  ��   f  � � � l     ��������  ��  ��   �  � � � i    � � � I      �������� 0 test_capitalize  ��  ��   � k     [ � �  � � � I     ��� � � z�� 
�� .���:AsRenull��� ��� null��   � �� � �
�� 
Valu � l  	  ����� � I  	  � ��� � z�� 
�� .Txt:CapTnull���     ctxt � m     � � � � �  F O � B � R��  ��  ��   � �� ���
�� 
Equa � m     � � � � �  F o � b � r��   �  ��� � X    [ ��� � � I  6 V ��� � � z�� 
�� .���:AsErnull��� ��� null��   � �� � �
�� 
Args � n  C H � � � 1   D H��
�� 
pcnt � o   C D���� 0 aref aRef � �� ���
�� 
Equa � K   I Q � � �� ����� 0 errornumber errorNumber � m   L O�����Y��  ��  �� 0 aref aRef � J   ! * � �  � � � K   ! % � � �� ���� 0 a   � m   " # � � � � �  f o o�   �  ��~ � J   % ( � �  ��} � 1   % &�|
�| 
ascr�}  �~  ��   �  � � � l     �{�z�y�{  �z  �y   �  � � � i    � � � I      �x ��w�x 0 call_uppercase   �  ��v � o      �u�u 	0 param  �v  �w   � I     � ��t � z�s 
�s .Txt:UppTnull���     ctxt � o    �r�r 	0 param  �t   �  � � � l     �q�p�o�q  �p  �o   �  � � � i    � � � I      �n ��m�n 0 call_lowercase   �  ��l � o      �k�k 	0 param  �l  �m   � I     � ��j � z�i 
�i .Txt:LowTnull���     ctxt � o    �h�h 	0 param  �j   �  � � � l     �g�f�e�g  �f  �e   �  � � � i    � � � I      �d ��c�d 0 call_capitalize   �  ��b � o      �a�a 	0 param  �b  �c   � I     � ��` � z�_ 
�_ .Txt:CapTnull���     ctxt � o    �^�^ 	0 param  �`   �  ��] � l     �\�[�Z�\  �[  �Z  �]     � � � l     �Y�X�W�Y  �X  �W   �  � � � l     �V�U�T�V  �U  �T   �  � � � h   , 3�S ��S $0 suite_formattext suite_FormatText � k       � �  � � � l     �R�Q�P�R  �Q  �P   �  � � � j     �O ��O 	0 _date   � m     �N
�N 
msng �  � � � j    �M ��M 0 	_testdata 	_testData � m    �L
�L 
msng �  � � � l     �K�J�I�K  �J  �I   �  � � � i   	 � � � I      �H�G�F�H "0 configure_setup configure_setUp�G  �F   � k     @ � �  � � � r      � � � I    �E�D�C
�E .misccurdldt    ��� null�D  �C   � o      �B�B 	0 _date   �  ��A � r    @ � � � J    : � �  � � � l 	   ��@�? � J     � �  � � � l    ��>�= � m     � � @�������>  �=   �  ��< � l    �;�:  c     m     @������ m    �9
�9 
ctxt�;  �:  �<  �@  �?   �  l 	  �8�7 J     	 l   
�6�5
 m     �  �6  �5  	 �4 l   �3�2 m     �  " "�3  �2  �4  �8  �7    l 	  +�1�0 J    +  l    �/�. J       m     �  f o o  m    �-�-    m    �,
�, boovtrue  !�+! o    �*�* 	0 _date  �+  �/  �.   "�)" l    )#�(�'# b     )$%$ b     '&'& m     !(( �)) . { " f o o " ,   1 ,   t r u e ,   d a t e   "' o   ! &�&�& 	0 _date  % m   ' (** �++  " }�(  �'  �)  �1  �0   ,�%, l 	 + 8-�$�#- l 
 + 8.�"�!. J   + 8// 010 l  + 32� �2 K   + 333 �45� 0 a  4 m   , -�
� 
msng5 �67
� 
pnam6 m   . /�
� 
alis7 �8�
� 
pcls8 m   0 1�
� 
docu�  �   �  1 9�9 l  3 6:��: m   3 6;; �<< Z { a : m i s s i n g   v a l u e ,   n a m e : a l i a s ,   c l a s s : d o c u m e n t }�  �  �  �"  �!  �$  �#  �%   � o      �� 0 	_testdata 	_testData�A   � =>= l     ����  �  �  > ?@? i  
 ABA I      ���� 80 test_literalrepresentation test_literalRepresentation�  �  B X     IC�DC k    DEE FGF r    $HIH o    �� 0 aref aRefI J      JJ KLK o      �� 0 avalue aValueL M�
M o      �	�	  0 expectedresult expectedResult�
  G N�N I  % DO�PO z� 
� .���:AsRenull��� ��� null�  P �QR
� 
ValuQ l  . =S��S I  . =T�UT z� 
� .Txt:FLitnull��� ��� null�  U � V��
�  
For_V o   7 8���� 0 avalue aValue��  �  �  R ��W��
�� 
EquaW o   > ?����  0 expectedresult expectedResult��  �  � 0 aref aRefD o    ���� 0 	_testdata 	_testData@ X��X l     ��������  ��  ��  ��   � YZY l     ��������  ��  ��  Z [\[ l     ��������  ��  ��  \ ]^] i   4 7_`_ I     ������
�� .aevtoappnull  �   � ****��  ��  ` l    abca I    ��d��
�� .sysoexecTEXT���     TEXTd b     efe m     gg �hh  ~ / b i n / o s a t e s t  f n    
iji 1    
��
�� 
strqj n    klk 1    ��
�� 
psxpl l   m����m I   ��n��
�� .earsffdralis        afdrn  f    ��  ��  ��  ��  b [ U handy for running tests in Script Editor (assumes `osatest` is installed in `~/bin`)   c �oo �   h a n d y   f o r   r u n n i n g   t e s t s   i n   S c r i p t   E d i t o r   ( a s s u m e s   ` o s a t e s t `   i s   i n s t a l l e d   i n   ` ~ / b i n ` )^ pqp l     ��������  ��  ��  q r��r l     ��������  ��  ��  ��       ��stuvw��  s ��������
�� 
pimr�� $0 suite_modifytext suite_ModifyText�� $0 suite_formattext suite_FormatText
�� .aevtoappnull  �   � ****t ��x�� x  yz{y ��|��
�� 
cobj| }}   �� 	
�� 
scpt��  z ��~��
�� 
cobj~    ��
�� 
osax��  { �����
�� 
cobj� ��   �� 
�� 
scpt��  u ��    ��� $0 suite_modifytext suite_ModifyText� �����������  � �������������� 0 test_uppercase  �� 0 test_lowercase  �� 0 test_capitalize  �� 0 call_uppercase  �� 0 call_lowercase  �� 0 call_capitalize  � �� *���������� 0 test_uppercase  ��  ��  � ���� 0 aref aRef� �� 	��  5���� 9�� 	������ 	  G������ ^�������� 	����������
�� 
scpt
�� 
Valu
�� .Txt:UppTnull���     ctxt
�� 
Equa
�� 
Usin
�� .���:ExEqnull��� ��� null�� 
�� .���:AsRenull��� ��� null
�� 
ctxt�� �� 0 a  
�� 
ascr
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
Args
�� 
pcnt�� 0 errornumber errorNumber���Y
�� .���:AsErnull��� ��� null�� �)��/ %*�)��/ �j U���)��/ *j 
U� UO)��/ *�)��/ �j U��a &a  UO Ha a l_ kvlv[a a l kh  )�a / *a �a ,�a a la  U[OY��� �� h���������� 0 test_lowercase  ��  ��  � ���� 0 aref aRef� �� 	��  s���� v������ ��������� 	����������
�� 
scpt
�� 
Valu
�� .Txt:LowTnull���     ctxt
�� 
Equa�� 
�� .���:AsRenull��� ��� null�� 0 a  
�� 
ascr
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
Args
�� 
pcnt�� 0 errornumber errorNumber���Y
�� .���:AsErnull��� ��� null�� \)��/ *�)��/ �j U��� 	UO <��l�kvlv[��l kh  )�a / *a �a ,�a a l� U[OY��� �� ����������� 0 test_capitalize  ��  ��  � ���� 0 aref aRef� �� 	��  ����� ������� ��������� 	����������
�� 
scpt
�� 
Valu
�� .Txt:CapTnull���     ctxt
�� 
Equa�� 
�� .���:AsRenull��� ��� null�� 0 a  
�� 
ascr
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
Args
�� 
pcnt�� 0 errornumber errorNumber���Y
�� .���:AsErnull��� ��� null�� \)��/ *�)��/ �j U��� 	UO <��l�kvlv[��l kh  )�a / *a �a ,�a a l� U[OY��� �� ����������� 0 call_uppercase  �� ��� �  �~�~ 	0 param  ��  � �}�} 	0 param  � �| �{
�| 
scpt
�{ .Txt:UppTnull���     ctxt�� )��/ �j U� �z ��y�x���w�z 0 call_lowercase  �y �v��v �  �u�u 	0 param  �x  � �t�t 	0 param  � �s �r
�s 
scpt
�r .Txt:LowTnull���     ctxt�w )��/ �j U� �q ��p�o���n�q 0 call_capitalize  �p �m��m �  �l�l 	0 param  �o  � �k�k 	0 param  � �j �i
�j 
scpt
�i .Txt:CapTnull���     ctxt�n )��/ �j Uv �h �  ��h $0 suite_formattext suite_FormatText� �g��f�e���g  � �d�c�b�a�d 	0 _date  �c 0 	_testdata 	_testData�b "0 configure_setup configure_setUp�a 80 test_literalrepresentation test_literalRepresentation
�f 
msng
�e 
msng� �` ��_�^���]�` "0 configure_setup configure_setUp�_  �^  �  � �\ ��[�Z(*�Y�X�W�V�U�T�S;
�\ .misccurdldt    ��� null
�[ 
ctxt�Z �Y 0 a  
�X 
msng
�W 
pnam
�V 
alis
�U 
pcls
�T 
docu�S �] A*j  Ec   O���&lv��lv�keb   �v�b   %�%lv�������a lv�vEc  � �RB�Q�P���O�R 80 test_literalrepresentation test_literalRepresentation�Q  �P  � �N�M�L�N 0 aref aRef�M 0 avalue aValue�L  0 expectedresult expectedResult� �K�J�I�H 	�G �F�E�D�C�B
�K 
kocl
�J 
cobj
�I .corecnte****       ****
�H 
scpt
�G 
Valu
�F 
For_
�E .Txt:FLitnull��� ��� null
�D 
Equa�C 
�B .���:AsRenull��� ��� null�O J Hb  [��l kh  �E[�k/E�Z[�l/E�ZO)��/ *�)��/ 	*�l U�� U[OY��w �A`�@�?���>
�A .aevtoappnull  �   � ****�@  �?  �  � g�=�<�;�:
�= .earsffdralis        afdr
�< 
psxp
�; 
strq
�: .sysoexecTEXT���     TEXT�> �)j �,�,%j ascr  ��ޭ