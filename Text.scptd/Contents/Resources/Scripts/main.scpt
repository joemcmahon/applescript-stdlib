FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� Text -- commonly-used text processing commands

Caution: When matching text item delimiters in text value, AppleScript uses the current scope's existing considering/ignoring case, diacriticals, hyphens, punctuation, white space and numeric strings settings; thus, wrapping a `search text` command in different considering/ignoring blocks can produce different results. For example, `search text "fud" for "F" will normally match the first character since AppleScript uses case-insensitive matching by default, whereas enclosing it in a `considering case` block will cause the same command to return zero matches. Conversely, `search text "f ud" for "fu"` will normally return zero matches as AppleScript considers white space by default, but when enclosed in an `ignoring white space` block will match the first three characters: "f u". This is how AppleScript is designed to work, but users need to be reminded of this as considering/ignoring blocks affect ALL script handlers called within that block, including nested calls (and all to any osax and application handlers that understand considering/ignoring attributes). (A much safer design would've restricted considering/ignoring blocks effect to their lexical scope by default; individual handlers would then using standard considering/ignoring behavior by default unless they use a `considering current options` block to indicate that the calling code's current considering/ignoring options should be used.)

TO DO:

- fix off-by-one error in `search text`:

	search text "ab" for "ab"
	--> {{class:matched text, startIndex:1, endIndex:1, foundText:"a", foundGroups:{}}} -- WRONG: should be `endIndex:2,foundText:"ab"`


- decide if predefined considering/ignoring options in `search text`, etc. should consider or ignore diacriticals and numeric strings; once decided, use same combinations for List library's text comparator for consistency

- also provide `exact match` option in `search text`/`split text` that considers case, diacriticals, hyphens, punctuation and white space but ignores numeric strings? currently, the `case insensitivity` and `case sensitivity` options both consider numeric strings (BTW, it might be better to replace `case sensitivity` with `exact match` to avoid having too many confusing options); also check just how much `considering numeric strings` affects matching (as opposed to ordering, which is its real intention)

- implement `normalize text theText using normalizationForm`? One could argue this is just out of scope for stdlib as AS itself does the sensible thing when dealing with composed vs decomposed glyphs, treating them as logically equal. The problem is when AS interfaces with other systems that aren't (including shell and NSString), at which point AS code should normalize text before handing it off to ensure consistent behavior.

	- AS preserves composed vs decomposed unicode chars as-is (getting `id` produces different results) but is smart enough to compare them as equal; however, it doesn't normalize when reading/writing or crossing ASOC bridge so written files will vary and NSString (which is old-school UTF16) compares them as not-equal, so any operations involving NSString's `isEqual[ToString]:` will need to normalize both strings first to ensure consistent behavior using one of the following NSString methods:
	
		decomposedStringWithCanonicalMapping (Unicode Normalization Form D)
		decomposedStringWithCompatibilityMapping (Unicode Normalization Form KD)
		precomposedStringWithCanonicalMapping (Unicode Normalization Form C)
		precomposedStringWithCompatibilityMapping (Unicode Normalization Form KC)

 	- note that Satimage.osax provides a `normalize unicode` command, although it only covers 2 of 4 forms (most likely KD and KC) -- TO DO: use `precomposed characters` and `compatibility mapping` boolean params? (also, need to figure out which is preferred form to use as default: e.g. compiling "�" in SE gives precomposed form - though whether this is SE or AS or keyboard input has yet to be determined)



- NSRegularExpression doesn't normalize before matching


- `insert into text`, `delete from text` for inserting/replacing/deleting ranges of characters (c.f. `insert into list`, `delete from list` in List library)


- add `matching first item only` boolean option to `search text` (this allows users to perform incremental matching fairly efficiently without having to use an Iterator API)

- also allow `search text` handler's `replacing with` parameter to accept a script object containing a `replaceText` handler; this would take the match record produced by _findText()/_findPattern() and return the text to insert; useful when the replacement text is based on the original, e.g. when uppercasing matched text the user currently has to get a list of match records from `search text`, then iterate over it and replace each text range herself


- would it be worth implementing a `compare text` command that allows considering/ignoring options to be supplied as `considering`/`ignoring` parameters (considering/ignoring blocks can't be parameterized as they require hardcoded constants) as this would allow comparisons to be safely performed without having to futz with considering/ignoring blocks all the time (c.f. Number library's `compare number`); for extra flexibility, the comparator constructor should also be exposed as a public command, and the returned object implement the same `makeKey`+`compareItems` methods as List library's sort comparators, allowing them to be used interchangeably (one could even argue for putting all comparators into their own lib, which other libraries and user scripts can import whenever they need to parameterize comparison behavior)

- Q. what difference does locale make to uppercase/capitalize/lowercase text?

- what, if any, additional localization info (via NSLocale) might be relevant/useful to AS users?



- not sure about formatting type class and symbol constants in `literal representation` (IIRC, AS only binds application info to reference objects, not type/constant objects, in which case only terms defined in AS's own dictionary will format as keywords and the rest will format using raw chevron syntax (though currently even app specifers, which do know app identity, appear as raw syntax)

     � 	 	12   T e x t   - -   c o m m o n l y - u s e d   t e x t   p r o c e s s i n g   c o m m a n d s 
 
 C a u t i o n :   W h e n   m a t c h i n g   t e x t   i t e m   d e l i m i t e r s   i n   t e x t   v a l u e ,   A p p l e S c r i p t   u s e s   t h e   c u r r e n t   s c o p e ' s   e x i s t i n g   c o n s i d e r i n g / i g n o r i n g   c a s e ,   d i a c r i t i c a l s ,   h y p h e n s ,   p u n c t u a t i o n ,   w h i t e   s p a c e   a n d   n u m e r i c   s t r i n g s   s e t t i n g s ;   t h u s ,   w r a p p i n g   a   ` s e a r c h   t e x t `   c o m m a n d   i n   d i f f e r e n t   c o n s i d e r i n g / i g n o r i n g   b l o c k s   c a n   p r o d u c e   d i f f e r e n t   r e s u l t s .   F o r   e x a m p l e ,   ` s e a r c h   t e x t   " f u d "   f o r   " F "   w i l l   n o r m a l l y   m a t c h   t h e   f i r s t   c h a r a c t e r   s i n c e   A p p l e S c r i p t   u s e s   c a s e - i n s e n s i t i v e   m a t c h i n g   b y   d e f a u l t ,   w h e r e a s   e n c l o s i n g   i t   i n   a   ` c o n s i d e r i n g   c a s e `   b l o c k   w i l l   c a u s e   t h e   s a m e   c o m m a n d   t o   r e t u r n   z e r o   m a t c h e s .   C o n v e r s e l y ,   ` s e a r c h   t e x t   " f   u d "   f o r   " f u " `   w i l l   n o r m a l l y   r e t u r n   z e r o   m a t c h e s   a s   A p p l e S c r i p t   c o n s i d e r s   w h i t e   s p a c e   b y   d e f a u l t ,   b u t   w h e n   e n c l o s e d   i n   a n   ` i g n o r i n g   w h i t e   s p a c e `   b l o c k   w i l l   m a t c h   t h e   f i r s t   t h r e e   c h a r a c t e r s :   " f   u " .   T h i s   i s   h o w   A p p l e S c r i p t   i s   d e s i g n e d   t o   w o r k ,   b u t   u s e r s   n e e d   t o   b e   r e m i n d e d   o f   t h i s   a s   c o n s i d e r i n g / i g n o r i n g   b l o c k s   a f f e c t   A L L   s c r i p t   h a n d l e r s   c a l l e d   w i t h i n   t h a t   b l o c k ,   i n c l u d i n g   n e s t e d   c a l l s   ( a n d   a l l   t o   a n y   o s a x   a n d   a p p l i c a t i o n   h a n d l e r s   t h a t   u n d e r s t a n d   c o n s i d e r i n g / i g n o r i n g   a t t r i b u t e s ) .   ( A   m u c h   s a f e r   d e s i g n   w o u l d ' v e   r e s t r i c t e d   c o n s i d e r i n g / i g n o r i n g   b l o c k s   e f f e c t   t o   t h e i r   l e x i c a l   s c o p e   b y   d e f a u l t ;   i n d i v i d u a l   h a n d l e r s   w o u l d   t h e n   u s i n g   s t a n d a r d   c o n s i d e r i n g / i g n o r i n g   b e h a v i o r   b y   d e f a u l t   u n l e s s   t h e y   u s e   a   ` c o n s i d e r i n g   c u r r e n t   o p t i o n s `   b l o c k   t o   i n d i c a t e   t h a t   t h e   c a l l i n g   c o d e ' s   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   s h o u l d   b e   u s e d . ) 
 
 T O   D O : 
 
 -   f i x   o f f - b y - o n e   e r r o r   i n   ` s e a r c h   t e x t ` : 
 
 	 s e a r c h   t e x t   " a b "   f o r   " a b " 
 	 - - >   { { c l a s s : m a t c h e d   t e x t ,   s t a r t I n d e x : 1 ,   e n d I n d e x : 1 ,   f o u n d T e x t : " a " ,   f o u n d G r o u p s : { } } }   - -   W R O N G :   s h o u l d   b e   ` e n d I n d e x : 2 , f o u n d T e x t : " a b " ` 
 
 
 -   d e c i d e   i f   p r e d e f i n e d   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   i n   ` s e a r c h   t e x t ` ,   e t c .   s h o u l d   c o n s i d e r   o r   i g n o r e   d i a c r i t i c a l s   a n d   n u m e r i c   s t r i n g s ;   o n c e   d e c i d e d ,   u s e   s a m e   c o m b i n a t i o n s   f o r   L i s t   l i b r a r y ' s   t e x t   c o m p a r a t o r   f o r   c o n s i s t e n c y 
 
 -   a l s o   p r o v i d e   ` e x a c t   m a t c h `   o p t i o n   i n   ` s e a r c h   t e x t ` / ` s p l i t   t e x t `   t h a t   c o n s i d e r s   c a s e ,   d i a c r i t i c a l s ,   h y p h e n s ,   p u n c t u a t i o n   a n d   w h i t e   s p a c e   b u t   i g n o r e s   n u m e r i c   s t r i n g s ?   c u r r e n t l y ,   t h e   ` c a s e   i n s e n s i t i v i t y `   a n d   ` c a s e   s e n s i t i v i t y `   o p t i o n s   b o t h   c o n s i d e r   n u m e r i c   s t r i n g s   ( B T W ,   i t   m i g h t   b e   b e t t e r   t o   r e p l a c e   ` c a s e   s e n s i t i v i t y `   w i t h   ` e x a c t   m a t c h `   t o   a v o i d   h a v i n g   t o o   m a n y   c o n f u s i n g   o p t i o n s ) ;   a l s o   c h e c k   j u s t   h o w   m u c h   ` c o n s i d e r i n g   n u m e r i c   s t r i n g s `   a f f e c t s   m a t c h i n g   ( a s   o p p o s e d   t o   o r d e r i n g ,   w h i c h   i s   i t s   r e a l   i n t e n t i o n ) 
 
 -   i m p l e m e n t   ` n o r m a l i z e   t e x t   t h e T e x t   u s i n g   n o r m a l i z a t i o n F o r m ` ?   O n e   c o u l d   a r g u e   t h i s   i s   j u s t   o u t   o f   s c o p e   f o r   s t d l i b   a s   A S   i t s e l f   d o e s   t h e   s e n s i b l e   t h i n g   w h e n   d e a l i n g   w i t h   c o m p o s e d   v s   d e c o m p o s e d   g l y p h s ,   t r e a t i n g   t h e m   a s   l o g i c a l l y   e q u a l .   T h e   p r o b l e m   i s   w h e n   A S   i n t e r f a c e s   w i t h   o t h e r   s y s t e m s   t h a t   a r e n ' t   ( i n c l u d i n g   s h e l l   a n d   N S S t r i n g ) ,   a t   w h i c h   p o i n t   A S   c o d e   s h o u l d   n o r m a l i z e   t e x t   b e f o r e   h a n d i n g   i t   o f f   t o   e n s u r e   c o n s i s t e n t   b e h a v i o r . 
 
 	 -   A S   p r e s e r v e s   c o m p o s e d   v s   d e c o m p o s e d   u n i c o d e   c h a r s   a s - i s   ( g e t t i n g   ` i d `   p r o d u c e s   d i f f e r e n t   r e s u l t s )   b u t   i s   s m a r t   e n o u g h   t o   c o m p a r e   t h e m   a s   e q u a l ;   h o w e v e r ,   i t   d o e s n ' t   n o r m a l i z e   w h e n   r e a d i n g / w r i t i n g   o r   c r o s s i n g   A S O C   b r i d g e   s o   w r i t t e n   f i l e s   w i l l   v a r y   a n d   N S S t r i n g   ( w h i c h   i s   o l d - s c h o o l   U T F 1 6 )   c o m p a r e s   t h e m   a s   n o t - e q u a l ,   s o   a n y   o p e r a t i o n s   i n v o l v i n g   N S S t r i n g ' s   ` i s E q u a l [ T o S t r i n g ] : `   w i l l   n e e d   t o   n o r m a l i z e   b o t h   s t r i n g s   f i r s t   t o   e n s u r e   c o n s i s t e n t   b e h a v i o r   u s i n g   o n e   o f   t h e   f o l l o w i n g   N S S t r i n g   m e t h o d s : 
 	 
 	 	 d e c o m p o s e d S t r i n g W i t h C a n o n i c a l M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   D ) 
 	 	 d e c o m p o s e d S t r i n g W i t h C o m p a t i b i l i t y M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   K D ) 
 	 	 p r e c o m p o s e d S t r i n g W i t h C a n o n i c a l M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   C ) 
 	 	 p r e c o m p o s e d S t r i n g W i t h C o m p a t i b i l i t y M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   K C ) 
 
   	 -   n o t e   t h a t   S a t i m a g e . o s a x   p r o v i d e s   a   ` n o r m a l i z e   u n i c o d e `   c o m m a n d ,   a l t h o u g h   i t   o n l y   c o v e r s   2   o f   4   f o r m s   ( m o s t   l i k e l y   K D   a n d   K C )   - -   T O   D O :   u s e   ` p r e c o m p o s e d   c h a r a c t e r s `   a n d   ` c o m p a t i b i l i t y   m a p p i n g `   b o o l e a n   p a r a m s ?   ( a l s o ,   n e e d   t o   f i g u r e   o u t   w h i c h   i s   p r e f e r r e d   f o r m   t o   u s e   a s   d e f a u l t :   e . g .   c o m p i l i n g   " � "   i n   S E   g i v e s   p r e c o m p o s e d   f o r m   -   t h o u g h   w h e t h e r   t h i s   i s   S E   o r   A S   o r   k e y b o a r d   i n p u t   h a s   y e t   t o   b e   d e t e r m i n e d ) 
 
 
 
 -   N S R e g u l a r E x p r e s s i o n   d o e s n ' t   n o r m a l i z e   b e f o r e   m a t c h i n g 
 
 
 -   ` i n s e r t   i n t o   t e x t ` ,   ` d e l e t e   f r o m   t e x t `   f o r   i n s e r t i n g / r e p l a c i n g / d e l e t i n g   r a n g e s   o f   c h a r a c t e r s   ( c . f .   ` i n s e r t   i n t o   l i s t ` ,   ` d e l e t e   f r o m   l i s t `   i n   L i s t   l i b r a r y ) 
 
 
 -   a d d   ` m a t c h i n g   f i r s t   i t e m   o n l y `   b o o l e a n   o p t i o n   t o   ` s e a r c h   t e x t `   ( t h i s   a l l o w s   u s e r s   t o   p e r f o r m   i n c r e m e n t a l   m a t c h i n g   f a i r l y   e f f i c i e n t l y   w i t h o u t   h a v i n g   t o   u s e   a n   I t e r a t o r   A P I ) 
 
 -   a l s o   a l l o w   ` s e a r c h   t e x t `   h a n d l e r ' s   ` r e p l a c i n g   w i t h `   p a r a m e t e r   t o   a c c e p t   a   s c r i p t   o b j e c t   c o n t a i n i n g   a   ` r e p l a c e T e x t `   h a n d l e r ;   t h i s   w o u l d   t a k e   t h e   m a t c h   r e c o r d   p r o d u c e d   b y   _ f i n d T e x t ( ) / _ f i n d P a t t e r n ( )   a n d   r e t u r n   t h e   t e x t   t o   i n s e r t ;   u s e f u l   w h e n   t h e   r e p l a c e m e n t   t e x t   i s   b a s e d   o n   t h e   o r i g i n a l ,   e . g .   w h e n   u p p e r c a s i n g   m a t c h e d   t e x t   t h e   u s e r   c u r r e n t l y   h a s   t o   g e t   a   l i s t   o f   m a t c h   r e c o r d s   f r o m   ` s e a r c h   t e x t ` ,   t h e n   i t e r a t e   o v e r   i t   a n d   r e p l a c e   e a c h   t e x t   r a n g e   h e r s e l f 
 
 
 -   w o u l d   i t   b e   w o r t h   i m p l e m e n t i n g   a   ` c o m p a r e   t e x t `   c o m m a n d   t h a t   a l l o w s   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   t o   b e   s u p p l i e d   a s   ` c o n s i d e r i n g ` / ` i g n o r i n g `   p a r a m e t e r s   ( c o n s i d e r i n g / i g n o r i n g   b l o c k s   c a n ' t   b e   p a r a m e t e r i z e d   a s   t h e y   r e q u i r e   h a r d c o d e d   c o n s t a n t s )   a s   t h i s   w o u l d   a l l o w   c o m p a r i s o n s   t o   b e   s a f e l y   p e r f o r m e d   w i t h o u t   h a v i n g   t o   f u t z   w i t h   c o n s i d e r i n g / i g n o r i n g   b l o c k s   a l l   t h e   t i m e   ( c . f .   N u m b e r   l i b r a r y ' s   ` c o m p a r e   n u m b e r ` ) ;   f o r   e x t r a   f l e x i b i l i t y ,   t h e   c o m p a r a t o r   c o n s t r u c t o r   s h o u l d   a l s o   b e   e x p o s e d   a s   a   p u b l i c   c o m m a n d ,   a n d   t h e   r e t u r n e d   o b j e c t   i m p l e m e n t   t h e   s a m e   ` m a k e K e y ` + ` c o m p a r e I t e m s `   m e t h o d s   a s   L i s t   l i b r a r y ' s   s o r t   c o m p a r a t o r s ,   a l l o w i n g   t h e m   t o   b e   u s e d   i n t e r c h a n g e a b l y   ( o n e   c o u l d   e v e n   a r g u e   f o r   p u t t i n g   a l l   c o m p a r a t o r s   i n t o   t h e i r   o w n   l i b ,   w h i c h   o t h e r   l i b r a r i e s   a n d   u s e r   s c r i p t s   c a n   i m p o r t   w h e n e v e r   t h e y   n e e d   t o   p a r a m e t e r i z e   c o m p a r i s o n   b e h a v i o r ) 
 
 -   Q .   w h a t   d i f f e r e n c e   d o e s   l o c a l e   m a k e   t o   u p p e r c a s e / c a p i t a l i z e / l o w e r c a s e   t e x t ? 
 
 -   w h a t ,   i f   a n y ,   a d d i t i o n a l   l o c a l i z a t i o n   i n f o   ( v i a   N S L o c a l e )   m i g h t   b e   r e l e v a n t / u s e f u l   t o   A S   u s e r s ? 
 
 
 
 -   n o t   s u r e   a b o u t   f o r m a t t i n g   t y p e   c l a s s   a n d   s y m b o l   c o n s t a n t s   i n   ` l i t e r a l   r e p r e s e n t a t i o n `   ( I I R C ,   A S   o n l y   b i n d s   a p p l i c a t i o n   i n f o   t o   r e f e r e n c e   o b j e c t s ,   n o t   t y p e / c o n s t a n t   o b j e c t s ,   i n   w h i c h   c a s e   o n l y   t e r m s   d e f i n e d   i n   A S ' s   o w n   d i c t i o n a r y   w i l l   f o r m a t   a s   k e y w o r d s   a n d   t h e   r e s t   w i l l   f o r m a t   u s i n g   r a w   c h e v r o n   s y n t a x   ( t h o u g h   c u r r e n t l y   e v e n   a p p   s p e c i f e r s ,   w h i c h   d o   k n o w   a p p   i d e n t i t y ,   a p p e a r   a s   r a w   s y n t a x ) 
 
   
  
 l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        l     ��������  ��  ��        j    �� �� 60 _textsupportagentbundleid _TextSupportAgentBundleID  m       �   d c o m . a p p l e . S c r i p t E d i t o r . i d . l i b r a r y . T e x t . T e x t S u p p o r t      l     ��������  ��  ��        l     ��������  ��  ��         l     �� ! "��   ! J D--------------------------------------------------------------------    " � # # � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -    $ % $ l     �� & '��   &   record types    ' � ( (    r e c o r d   t y p e s %  ) * ) l     ��������  ��  ��   *  + , + j    �� -�� (0 _unmatchedtexttype _UnmatchedTextType - m    ��
�� 
TxtU ,  . / . j    �� 0�� $0 _matchedtexttype _MatchedTextType 0 m    ��
�� 
TxtM /  1 2 1 j    �� 3�� &0 _matchedgrouptype _MatchedGroupType 3 m    ��
�� 
TxtG 2  4 5 4 l     ��������  ��  ��   5  6 7 6 l     ��������  ��  ��   7  8 9 8 l     �� : ;��   : J D--------------------------------------------------------------------    ; � < < � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 9  = > = l     �� ? @��   ?   support    @ � A A    s u p p o r t >  B C B l     ��������  ��  ��   C  D E D l      F G H F j    �� I�� 0 _support   I N     J J 4    �� K
�� 
scpt K m     L L � M M  T y p e S u p p o r t G "  used for parameter checking    H � N N 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g E  O P O l     ��������  ��  ��   P  Q R Q l     ��������  ��  ��   R  S T S i   ! U V U I      �� W���� 
0 _error   W  X Y X o      ���� 0 handlername handlerName Y  Z [ Z o      ���� 0 etext eText [  \ ] \ o      ���� 0 enumber eNumber ]  ^ _ ^ o      ���� 0 efrom eFrom _  `�� ` o      ���� 
0 eto eTo��  ��   V n     a b a I    �� c���� &0 throwcommanderror throwCommandError c  d e d m     f f � g g  T e x t e  h i h o    ���� 0 handlername handlerName i  j k j o    ���� 0 etext eText k  l m l o    	���� 0 enumber eNumber m  n o n o   	 
���� 0 efrom eFrom o  p�� p o   
 ���� 
0 eto eTo��  ��   b o     ���� 0 _support   T  q r q l     ��������  ��  ��   r  s t s l     �� u v��   u J D--------------------------------------------------------------------    v � w w � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - t  x y x l     �� z {��   z   Find and Replace Suite    { � | | .   F i n d   a n d   R e p l a c e   S u i t e y  } ~ } l     ��������  ��  ��   ~   �  l     �� � ���   �   find pattern    � � � �    f i n d   p a t t e r n �  � � � l     ��������  ��  ��   �  � � � i  " % � � � I      �� ����� $0 _matchinforecord _matchInfoRecord �  � � � o      ���� 0 
asocstring 
asocString �  � � � o      ����  0 asocmatchrange asocMatchRange �  � � � o      ���� 0 
textoffset 
textOffset �  ��� � o      ���� 0 
recordtype 
recordType��  ��   � k     # � �  � � � r     
 � � � c      � � � l     ����� � n     � � � I    �� ����� *0 substringwithrange_ substringWithRange_ �  ��� � o    ����  0 asocmatchrange asocMatchRange��  ��   � o     ���� 0 
asocstring 
asocString��  ��   � m    ��
�� 
ctxt � o      ���� 0 	foundtext 	foundText �  � � � l    � � � � r     � � � [     � � � o    ���� 0 
textoffset 
textOffset � l    ����� � n     � � � 1    ��
�� 
leng � o    ���� 0 	foundtext 	foundText��  ��   � o      ����  0 nexttextoffset nextTextOffset � : 4 calculate the start index of the next AS text range    � � � � h   c a l c u l a t e   t h e   s t a r t   i n d e x   o f   t h e   n e x t   A S   t e x t   r a n g e �  � � � l   �� � ���   �
 note: record keys are identifiers, not keywords, as 1. library-defined keywords are a huge pain to use outside of `tell script...` blocks and 2. importing the library's terminology into the global namespace via `use script...` is an excellent way to create keyword conflicts; only the class value is a keyword since Script Editor/OSAKit don't correctly handle records that use non-typename values (e.g. `{class:"matched text",...}`), but this shouldn't impact usability as it's really only used for informational purposes    � � � �   n o t e :   r e c o r d   k e y s   a r e   i d e n t i f i e r s ,   n o t   k e y w o r d s ,   a s   1 .   l i b r a r y - d e f i n e d   k e y w o r d s   a r e   a   h u g e   p a i n   t o   u s e   o u t s i d e   o f   ` t e l l   s c r i p t . . . `   b l o c k s   a n d   2 .   i m p o r t i n g   t h e   l i b r a r y ' s   t e r m i n o l o g y   i n t o   t h e   g l o b a l   n a m e s p a c e   v i a   ` u s e   s c r i p t . . . `   i s   a n   e x c e l l e n t   w a y   t o   c r e a t e   k e y w o r d   c o n f l i c t s ;   o n l y   t h e   c l a s s   v a l u e   i s   a   k e y w o r d   s i n c e   S c r i p t   E d i t o r / O S A K i t   d o n ' t   c o r r e c t l y   h a n d l e   r e c o r d s   t h a t   u s e   n o n - t y p e n a m e   v a l u e s   ( e . g .   ` { c l a s s : " m a t c h e d   t e x t " , . . . } ` ) ,   b u t   t h i s   s h o u l d n ' t   i m p a c t   u s a b i l i t y   a s   i t ' s   r e a l l y   o n l y   u s e d   f o r   i n f o r m a t i o n a l   p u r p o s e s �  ��� � l   # � � � � L    # � � J    " � �  � � � K     � � �� � �
�� 
pcls � o    ���� 0 
recordtype 
recordType � �� � ��� 0 
startindex 
startIndex � o    ���� 0 
textoffset 
textOffset � �� � ��� 0 endindex endIndex � \     � � � o    ����  0 nexttextoffset nextTextOffset � m    ����  � �� ����� 0 	foundtext 	foundText � o    ���� 0 	foundtext 	foundText��   �  ��� � o     ����  0 nexttextoffset nextTextOffset��   � | v TO DO: use fromIndex/toIndex instead of startIndex/endIndex? (see also List; consistent naming would be good to have)    � � � � �   T O   D O :   u s e   f r o m I n d e x / t o I n d e x   i n s t e a d   o f   s t a r t I n d e x / e n d I n d e x ?   ( s e e   a l s o   L i s t ;   c o n s i s t e n t   n a m i n g   w o u l d   b e   g o o d   t o   h a v e )��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � i  & ) � � � I      �� ����� 0 _matchrecords _matchRecords �  � � � o      ���� 0 
asocstring 
asocString �  � � � o      ����  0 asocmatchrange asocMatchRange �  � � � o      ����  0 asocstartindex asocStartIndex �  � � � o      ���� 0 
textoffset 
textOffset �  � � � o      �� (0 nonmatchrecordtype nonMatchRecordType �  ��~ � o      �}�} "0 matchrecordtype matchRecordType�~  ��   � k     V � �  � � � l     �| � ��|   � � � important: NSString character indexes aren't guaranteed to be same as AS character indexes, so reconstruct both non-matching and matching AS text values, and calculate accurate AS character ranges from those    � � � ��   i m p o r t a n t :   N S S t r i n g   c h a r a c t e r   i n d e x e s   a r e n ' t   g u a r a n t e e d   t o   b e   s a m e   a s   A S   c h a r a c t e r   i n d e x e s ,   s o   r e c o n s t r u c t   b o t h   n o n - m a t c h i n g   a n d   m a t c h i n g   A S   t e x t   v a l u e s ,   a n d   c a l c u l a t e   a c c u r a t e   A S   c h a r a c t e r   r a n g e s   f r o m   t h o s e �  � � � r      � � � n     � � � I    �{�z�y�{ 0 location  �z  �y   � o     �x�x  0 asocmatchrange asocMatchRange � o      �w�w  0 asocmatchstart asocMatchStart �  � � � r     � � � [     � � � o    	�v�v  0 asocmatchstart asocMatchStart � l  	  ��u�t � n  	  � � � I   
 �s�r�q�s 
0 length  �r  �q   � o   	 
�p�p  0 asocmatchrange asocMatchRange�u  �t   � o      �o�o 0 asocmatchend asocMatchEnd �  � � � r     � � � K     � � �n � ��n 0 location   � o    �m�m  0 asocstartindex asocStartIndex � �l ��k�l 
0 length   � \     � � � o    �j�j  0 asocmatchstart asocMatchStart � o    �i�i  0 asocstartindex asocStartIndex�k   � o      �h�h &0 asocnonmatchrange asocNonMatchRange �  � � � r    5 � � � I      �g ��f�g $0 _matchinforecord _matchInfoRecord �  � � � o    �e�e 0 
asocstring 
asocString �  � � � o     �d�d &0 asocnonmatchrange asocNonMatchRange �    o     !�c�c 0 
textoffset 
textOffset �b o   ! "�a�a (0 nonmatchrecordtype nonMatchRecordType�b  �f   � J        o      �`�` 0 nonmatchinfo nonMatchInfo �_ o      �^�^ 0 
textoffset 
textOffset�_   �  r   6 N	
	 I      �]�\�] $0 _matchinforecord _matchInfoRecord  o   7 8�[�[ 0 
asocstring 
asocString  o   8 9�Z�Z  0 asocmatchrange asocMatchRange  o   9 :�Y�Y 0 
textoffset 
textOffset �X o   : ;�W�W "0 matchrecordtype matchRecordType�X  �\  
 J        o      �V�V 0 	matchinfo 	matchInfo �U o      �T�T 0 
textoffset 
textOffset�U   �S L   O V J   O U  o   O P�R�R 0 nonmatchinfo nonMatchInfo  o   P Q�Q�Q 0 	matchinfo 	matchInfo  o   Q R�P�P 0 asocmatchend asocMatchEnd  �O  o   R S�N�N 0 
textoffset 
textOffset�O  �S   � !"! l     �M�L�K�M  �L  �K  " #$# l     �J�I�H�J  �I  �H  $ %&% i  * -'(' I      �G)�F�G &0 _matchedgrouplist _matchedGroupList) *+* o      �E�E 0 
asocstring 
asocString+ ,-, o      �D�D 0 	asocmatch 	asocMatch- ./. o      �C�C 0 
textoffset 
textOffset/ 0�B0 o      �A�A &0 includenonmatches includeNonMatches�B  �F  ( k     �11 232 r     454 J     �@�@  5 o      �?�? "0 submatchresults subMatchResults3 676 r    898 \    :;: l   
<�>�=< n   
=>= I    
�<�;�:�<  0 numberofranges numberOfRanges�;  �:  > o    �9�9 0 	asocmatch 	asocMatch�>  �=  ; m   
 �8�8 9 o      �7�7 0 groupindexes groupIndexes7 ?@? Z    �AB�6�5A ?    CDC o    �4�4 0 groupindexes groupIndexesD m    �3�3  B k    �EE FGF r    HIH n   JKJ I    �2L�1�2 0 rangeatindex_ rangeAtIndex_L M�0M m    �/�/  �0  �1  K o    �.�. 0 	asocmatch 	asocMatchI o      �-�- (0 asocfullmatchrange asocFullMatchRangeG NON r    %PQP n   #RSR I    #�,�+�*�, 0 location  �+  �*  S o    �)�) (0 asocfullmatchrange asocFullMatchRangeQ o      �(�( &0 asocnonmatchstart asocNonMatchStartO TUT r   & /VWV [   & -XYX o   & '�'�' &0 asocnonmatchstart asocNonMatchStartY l  ' ,Z�&�%Z n  ' ,[\[ I   ( ,�$�#�"�$ 
0 length  �#  �"  \ o   ' (�!�! (0 asocfullmatchrange asocFullMatchRange�&  �%  W o      � �  $0 asocfullmatchend asocFullMatchEndU ]^] Y   0 �_�`a�_ k   : �bb cdc r   : oefe I      �g�� 0 _matchrecords _matchRecordsg hih o   ; <�� 0 
asocstring 
asocStringi jkj n  < Blml I   = B�n�� 0 rangeatindex_ rangeAtIndex_n o�o o   = >�� 0 i  �  �  m o   < =�� 0 	asocmatch 	asocMatchk pqp o   B C�� &0 asocnonmatchstart asocNonMatchStartq rsr o   C D�� 0 
textoffset 
textOffsets tut o   D I�� (0 _unmatchedtexttype _UnmatchedTextTypeu v�v o   I N�� &0 _matchedgrouptype _MatchedGroupType�  �  f J      ww xyx o      �� 0 nonmatchinfo nonMatchInfoy z{z o      �� 0 	matchinfo 	matchInfo{ |}| o      �� &0 asocnonmatchstart asocNonMatchStart} ~�~ o      �� 0 
textoffset 
textOffset�  d � Z  p |����
� o   p q�	�	 &0 includenonmatches includeNonMatches� r   t x��� o   t u�� 0 nonmatchinfo nonMatchInfo� n      ���  ;   v w� o   u v�� "0 submatchresults subMatchResults�  �
  � ��� r   } ���� o   } ~�� 0 	matchinfo 	matchInfo� n      ���  ;    �� o   ~ �� "0 submatchresults subMatchResults�  � 0 i  ` m   3 4�� a o   4 5�� 0 groupindexes groupIndexes�  ^ ��� Z   � ���� ��� o   � ����� &0 includenonmatches includeNonMatches� k   � ��� ��� r   � ���� K   � ��� ������ 0 location  � o   � ����� &0 asocnonmatchstart asocNonMatchStart� ������� 
0 length  � \   � ���� o   � ����� $0 asocfullmatchend asocFullMatchEnd� o   � ����� &0 asocnonmatchstart asocNonMatchStart��  � o      ���� &0 asocnonmatchrange asocNonMatchRange� ���� r   � ���� n   � ���� 4   � ����
�� 
cobj� m   � ����� � I   � �������� $0 _matchinforecord _matchInfoRecord� ��� o   � ����� 0 
asocstring 
asocString� ��� o   � ����� &0 asocnonmatchrange asocNonMatchRange� ��� o   � ����� 0 
textoffset 
textOffset� ���� o   � ����� (0 _unmatchedtexttype _UnmatchedTextType��  ��  � n      ���  ;   � �� o   � ����� "0 submatchresults subMatchResults��  �   ��  �  �6  �5  @ ���� L   � ��� o   � ����� "0 submatchresults subMatchResults��  & ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  . 1��� I      ������� 0 _findpattern _findPattern� ��� o      ���� 0 thetext theText� ��� o      ���� 0 patterntext patternText� ��� o      ���� &0 includenonmatches includeNonMatches� ���� o      ����  0 includematches includeMatches��  ��  � k    �� ��� r     ��� n    ��� I    ������� (0 asbooleanparameter asBooleanParameter� ��� o    ���� &0 includenonmatches includeNonMatches� ���� m    �� ���  u n m a t c h e d   t e x t��  ��  � o     ���� 0 _support  � o      ���� &0 includenonmatches includeNonMatches� ��� r    ��� n   ��� I    ������� (0 asbooleanparameter asBooleanParameter� ��� o    ����  0 includematches includeMatches� ���� m    �� ���  m a t c h e d   t e x t��  ��  � o    ���� 0 _support  � o      ����  0 includematches includeMatches� ��� r    *��� n   (��� I   ! (������� @0 asnsregularexpressionparameter asNSRegularExpressionParameter� ��� o   ! "���� 0 patterntext patternText� ��� m   " #����  � ���� m   # $�� ���  f o r��  ��  � o    !���� 0 _support  � o      ���� 0 asocpattern asocPattern� ��� r   + 7��� n  + 5��� I   0 5������� ,0 asnormalizednsstring asNormalizedNSString� ���� o   0 1���� 0 thetext theText��  ��  � o   + 0���� 0 _support  � o      ���� 0 
asocstring 
asocString� ��� l  8 ;���� r   8 ;��� m   8 9����  � o      ���� &0 asocnonmatchstart asocNonMatchStart� G A used to calculate NSRanges for non-matching portions of NSString   � ��� �   u s e d   t o   c a l c u l a t e   N S R a n g e s   f o r   n o n - m a t c h i n g   p o r t i o n s   o f   N S S t r i n g� ��� l  < ?���� r   < ?��� m   < =���� � o      ���� 0 
textoffset 
textOffset� B < used to calculate correct AppleScript start and end indexes   � ��� x   u s e d   t o   c a l c u l a t e   c o r r e c t   A p p l e S c r i p t   s t a r t   a n d   e n d   i n d e x e s� ��� r   @ D� � J   @ B����    o      ���� 0 
resultlist 
resultList�  l  E E����   @ : iterate over each non-matched + matched range in NSString    � t   i t e r a t e   o v e r   e a c h   n o n - m a t c h e d   +   m a t c h e d   r a n g e   i n   N S S t r i n g  r   E V	 n  E T

 I   F T������ @0 matchesinstring_options_range_ matchesInString_options_range_  o   F G���� 0 
asocstring 
asocString  m   G H����   �� J   H P  m   H I����   �� n  I N I   J N�������� 
0 length  ��  ��   o   I J���� 0 
asocstring 
asocString��  ��  ��   o   E F���� 0 asocpattern asocPattern	 o      ����  0 asocmatcharray asocMatchArray  Y   W ����� k   g �  r   g o !  l  g m"����" n  g m#$# I   h m��%����  0 objectatindex_ objectAtIndex_% &��& o   h i���� 0 i  ��  ��  $ o   g h����  0 asocmatcharray asocMatchArray��  ��  ! o      ���� 0 	asocmatch 	asocMatch '(' l  p p��)*��  ) � � the first range in match identifies the text matched by the entire pattern, so generate records for full match and its preceding (unmatched) text   * �++$   t h e   f i r s t   r a n g e   i n   m a t c h   i d e n t i f i e s   t h e   t e x t   m a t c h e d   b y   t h e   e n t i r e   p a t t e r n ,   s o   g e n e r a t e   r e c o r d s   f o r   f u l l   m a t c h   a n d   i t s   p r e c e d i n g   ( u n m a t c h e d )   t e x t( ,-, r   p �./. I      ��0���� 0 _matchrecords _matchRecords0 121 o   q r���� 0 
asocstring 
asocString2 343 n  r x565 I   s x��7���� 0 rangeatindex_ rangeAtIndex_7 8��8 m   s t����  ��  ��  6 o   r s���� 0 	asocmatch 	asocMatch4 9:9 o   x y���� &0 asocnonmatchstart asocNonMatchStart: ;<; o   y z���� 0 
textoffset 
textOffset< =>= o   z ���� (0 _unmatchedtexttype _UnmatchedTextType> ?��? o    ����� $0 _matchedtexttype _MatchedTextType��  ��  / J      @@ ABA o      ���� 0 nonmatchinfo nonMatchInfoB CDC o      ���� 0 	matchinfo 	matchInfoD EFE o      ���� &0 asocnonmatchstart asocNonMatchStartF G��G o      ���� 0 
textoffset 
textOffset��  - HIH Z  � �JK����J o   � ����� &0 includenonmatches includeNonMatchesK r   � �LML o   � ����� 0 nonmatchinfo nonMatchInfoM n      NON  ;   � �O o   � ����� 0 
resultlist 
resultList��  ��  I P��P Z   � �QR����Q o   � �����  0 includematches includeMatchesR k   � �SS TUT l  � ���VW��  V any additional ranges in match identify text matched by group references within regexp pattern, e.g. "([0-9]{4})-([0-9]{2})-([0-9]{2})" will match `YYYY-MM-DD` style date strings, returning the entire text match, plus sub-matches representing year, month and day text   W �XX   a n y   a d d i t i o n a l   r a n g e s   i n   m a t c h   i d e n t i f y   t e x t   m a t c h e d   b y   g r o u p   r e f e r e n c e s   w i t h i n   r e g e x p   p a t t e r n ,   e . g .   " ( [ 0 - 9 ] { 4 } ) - ( [ 0 - 9 ] { 2 } ) - ( [ 0 - 9 ] { 2 } ) "   w i l l   m a t c h   ` Y Y Y Y - M M - D D `   s t y l e   d a t e   s t r i n g s ,   r e t u r n i n g   t h e   e n t i r e   t e x t   m a t c h ,   p l u s   s u b - m a t c h e s   r e p r e s e n t i n g   y e a r ,   m o n t h   a n d   d a y   t e x tU Y��Y r   � �Z[Z b   � �\]\ o   � ����� 0 	matchinfo 	matchInfo] K   � �^^ ��_���� 0 foundgroups foundGroups_ I   � ���`���� &0 _matchedgrouplist _matchedGroupList` aba o   � ��� 0 
asocstring 
asocStringb cdc o   � ��~�~ 0 	asocmatch 	asocMatchd efe n  � �ghg o   � ��}�} 0 
startindex 
startIndexh o   � ��|�| 0 	matchinfo 	matchInfof i�{i o   � ��z�z &0 includenonmatches includeNonMatches�{  ��  ��  [ n      jkj  ;   � �k o   � ��y�y 0 
resultlist 
resultList��  ��  ��  ��  �� 0 i   m   Z [�x�x   \   [ blml l  [ `n�w�vn n  [ `opo I   \ `�u�t�s�u 	0 count  �t  �s  p o   [ \�r�r  0 asocmatcharray asocMatchArray�w  �v  m m   ` a�q�q ��   qrq l  � ��pst�p  s "  add final non-matched range   t �uu 8   a d d   f i n a l   n o n - m a t c h e d   r a n g er vwv Z   �
xy�o�nx o   � ��m�m &0 includenonmatches includeNonMatchesy k   �zz {|{ r   � �}~} c   � �� l  � ���l�k� n  � ���� I   � ��j��i�j *0 substringfromindex_ substringFromIndex_� ��h� o   � ��g�g &0 asocnonmatchstart asocNonMatchStart�h  �i  � o   � ��f�f 0 
asocstring 
asocString�l  �k  � m   � ��e
�e 
ctxt~ o      �d�d 0 	foundtext 	foundText| ��c� r   ���� K   ��� �b��
�b 
pcls� o   � ��a�a (0 _unmatchedtexttype _UnmatchedTextType� �`���` 0 
startindex 
startIndex� o   � ��_�_ 0 
textoffset 
textOffset� �^���^ 0 endindex endIndex� n   � ���� 1   � ��]
�] 
leng� o   � ��\�\ 0 thetext theText� �[��Z�[ 0 	foundtext 	foundText� o   � ��Y�Y 0 	foundtext 	foundText�Z  � n      ���  ;  � o  �X�X 0 
resultlist 
resultList�c  �o  �n  w ��W� L  �� o  �V�V 0 
resultlist 
resultList�W  � ��� l     �U�T�S�U  �T  �S  � ��� l     �R�Q�P�R  �Q  �P  � ��� l     �O���O  �  -----   � ��� 
 - - - - -� ��� l     �N���N  �   replace pattern   � ���     r e p l a c e   p a t t e r n� ��� l     �M�L�K�M  �L  �K  � ��� i  2 5��� I      �J��I�J "0 _replacepattern _replacePattern� ��� o      �H�H 0 thetext theText� ��� o      �G�G 0 patterntext patternText� ��F� o      �E�E 0 templatetext templateText�F  �I  � k     -�� ��� r     ��� n    
��� I    
�D��C�D ,0 asnormalizednsstring asNormalizedNSString� ��B� o    �A�A 0 thetext theText�B  �C  � o     �@�@ 0 _support  � o      �?�? 0 
asocstring 
asocString� ��� r    ��� n   ��� I    �>��=�> @0 asnsregularexpressionparameter asNSRegularExpressionParameter� ��� o    �<�< 0 patterntext patternText� ��� m    �;�;  � ��:� m    �� ���  f o r�:  �=  � o    �9�9 0 _support  � o      �8�8 0 asocpattern asocPattern� ��7� L    -�� n   ,��� I    ,�6��5�6 |0 <stringbyreplacingmatchesinstring_options_range_withtemplate_ <stringByReplacingMatchesInString_options_range_withTemplate_� ��� l 
  ��4�3� o    �2�2 0 
asocstring 
asocString�4  �3  � ��� m    �1�1  � ��� J    '�� ��� m     �0�0  � ��/� n    %��� I   ! %�.�-�,�. 
0 length  �-  �,  � o     !�+�+ 0 
asocstring 
asocString�/  � ��*� o   ' (�)�) 0 templatetext templateText�*  �5  � o    �(�( 0 asocpattern asocPattern�7  � ��� l     �'�&�%�'  �&  �%  � ��� l     �$�#�"�$  �#  �"  � ��� l     �!���!  �  -----   � ��� 
 - - - - -� ��� l     � ���   �  
 find text   � ���    f i n d   t e x t� ��� l     ����  �  �  � ��� i  6 9��� I      ���� 0 	_findtext 	_findText� ��� o      �� 0 thetext theText� ��� o      �� 0 fortext forText� ��� o      �� &0 includenonmatches includeNonMatches� ��� o      ��  0 includematches includeMatches�  �  � k    (�� ��� l     ����  ��� TO DO: is it worth switching to a more efficient algorithim when hypens, punctuation, and white space are all considered and numeric strings ignored (the default)? i.e. given a fixed-length match, the endIndex of a match can be determined using `forText's length + startIndex - 1` instead of measuring the length of all remaining text after `text item i`; will need to implement both approaches and profile them to determine if it makes any significant difference to speed   � ����   T O   D O :   i s   i t   w o r t h   s w i t c h i n g   t o   a   m o r e   e f f i c i e n t   a l g o r i t h i m   w h e n   h y p e n s ,   p u n c t u a t i o n ,   a n d   w h i t e   s p a c e   a r e   a l l   c o n s i d e r e d   a n d   n u m e r i c   s t r i n g s   i g n o r e d   ( t h e   d e f a u l t ) ?   i . e .   g i v e n   a   f i x e d - l e n g t h   m a t c h ,   t h e   e n d I n d e x   o f   a   m a t c h   c a n   b e   d e t e r m i n e d   u s i n g   ` f o r T e x t ' s   l e n g t h   +   s t a r t I n d e x   -   1 `   i n s t e a d   o f   m e a s u r i n g   t h e   l e n g t h   o f   a l l   r e m a i n i n g   t e x t   a f t e r   ` t e x t   i t e m   i ` ;   w i l l   n e e d   t o   i m p l e m e n t   b o t h   a p p r o a c h e s   a n d   p r o f i l e   t h e m   t o   d e t e r m i n e   i f   i t   m a k e s   a n y   s i g n i f i c a n t   d i f f e r e n c e   t o   s p e e d� ��� l     ����  �  �  � � � l     Z    �� =     o     �� 0 fortext forText m     �		   R    �

� .ascrerr ****      � ****
 m     � � I n v a l i d    f o r    p a r a m e t e r   ( t e x t   i s   e m p t y ,   o r   o n l y   c o n t a i n s   c h a r a c t e r s   i g n o r e d   b y   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s ) �
� 
errn m    	���Y ��

� 
erob o   
 �	�	 0 fortext forText�
  �  �  �� checks if all characters in forText are ignored by current considering/ignoring settings (the alternative would be to return each character as a non-match separated by a zero-length match, but that's probably not what the user intended); note that unlike `aString's length = 0`, which is what library code normally uses to check for empty text, on this occasion we do want to take into account the current considering/ignoring settings so deliberately use `forText is ""` here. For example, when ignoring punctuation, searching for the TID `"!?"` is no different to searching for `""`, because all of its characters are being ignored when comparing the text being searched against the text being searched for. Thus, a simple `forText is ""` test can be used to check in advance if the text contains any matchable characters under the current considering/ignoring settings, and report a meaningful error if not.    �   c h e c k s   i f   a l l   c h a r a c t e r s   i n   f o r T e x t   a r e   i g n o r e d   b y   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s   ( t h e   a l t e r n a t i v e   w o u l d   b e   t o   r e t u r n   e a c h   c h a r a c t e r   a s   a   n o n - m a t c h   s e p a r a t e d   b y   a   z e r o - l e n g t h   m a t c h ,   b u t   t h a t ' s   p r o b a b l y   n o t   w h a t   t h e   u s e r   i n t e n d e d ) ;   n o t e   t h a t   u n l i k e   ` a S t r i n g ' s   l e n g t h   =   0 ` ,   w h i c h   i s   w h a t   l i b r a r y   c o d e   n o r m a l l y   u s e s   t o   c h e c k   f o r   e m p t y   t e x t ,   o n   t h i s   o c c a s i o n   w e   d o   w a n t   t o   t a k e   i n t o   a c c o u n t   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s   s o   d e l i b e r a t e l y   u s e   ` f o r T e x t   i s   " " `   h e r e .   F o r   e x a m p l e ,   w h e n   i g n o r i n g   p u n c t u a t i o n ,   s e a r c h i n g   f o r   t h e   T I D   ` " ! ? " `   i s   n o   d i f f e r e n t   t o   s e a r c h i n g   f o r   ` " " ` ,   b e c a u s e   a l l   o f   i t s   c h a r a c t e r s   a r e   b e i n g   i g n o r e d   w h e n   c o m p a r i n g   t h e   t e x t   b e i n g   s e a r c h e d   a g a i n s t   t h e   t e x t   b e i n g   s e a r c h e d   f o r .   T h u s ,   a   s i m p l e   ` f o r T e x t   i s   " " `   t e s t   c a n   b e   u s e d   t o   c h e c k   i n   a d v a n c e   i f   t h e   t e x t   c o n t a i n s   a n y   m a t c h a b l e   c h a r a c t e r s   u n d e r   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s ,   a n d   r e p o r t   a   m e a n i n g f u l   e r r o r   i f   n o t .   r     J    ��   o      �� 0 
resultlist 
resultList  r     n    1    �
� 
txdl 1    �
� 
ascr o      �� 0 oldtids oldTIDs  r    # o    �� 0 fortext forText n      !  1     "�
� 
txdl! 1     �
� 
ascr "#" r   $ '$%$ m   $ %� �  % o      ���� 0 
startindex 
startIndex# &'& r   ( 0()( n   ( .*+* 1   , .��
�� 
leng+ n   ( ,,-, 4   ) ,��.
�� 
citm. m   * +���� - o   ( )���� 0 thetext theText) o      ���� 0 endindex endIndex' /0/ Z   1 J12��31 B   1 4454 o   1 2���� 0 
startindex 
startIndex5 o   2 3���� 0 endindex endIndex2 r   7 D676 n   7 B898 7  8 B��:;
�� 
ctxt: o   < >���� 0 
startindex 
startIndex; o   ? A���� 0 endindex endIndex9 o   7 8���� 0 thetext theText7 o      ���� 0 	foundtext 	foundText��  3 r   G J<=< m   G H>> �??  = o      ���� 0 	foundtext 	foundText0 @A@ Z  K fBC����B o   K L���� &0 includenonmatches includeNonMatchesC r   O bDED K   O _FF ��GH
�� 
pclsG o   P U���� (0 _unmatchedtexttype _UnmatchedTextTypeH ��IJ�� 0 
startindex 
startIndexI o   V W���� 0 
startindex 
startIndexJ ��KL�� 0 endindex endIndexK o   X Y���� 0 endindex endIndexL ��M���� 0 	foundtext 	foundTextM o   Z [���� 0 	foundtext 	foundText��  E n      NON  ;   ` aO o   _ `���� 0 
resultlist 
resultList��  ��  A PQP Y   gR��ST��R k   wUU VWV r   w |XYX [   w zZ[Z o   w x���� 0 endindex endIndex[ m   x y���� Y o      ���� 0 
startindex 
startIndexW \]\ r   } �^_^ \   } �`a` l  } �b����b n   } �cdc 1   ~ ���
�� 
lengd o   } ~���� 0 thetext theText��  ��  a l  � �e����e n   � �fgf 1   � ���
�� 
lengg n   � �hih 7  � ���jk
�� 
ctxtj l  � �l����l 4   � ���m
�� 
citmm o   � ����� 0 i  ��  ��  k l  � �n����n 4   � ���o
�� 
citmo m   � ���������  ��  i o   � ����� 0 thetext theText��  ��  _ o      ���� 0 endindex endIndex] pqp Z   � �rs��tr B   � �uvu o   � ����� 0 
startindex 
startIndexv o   � ����� 0 endindex endIndexs r   � �wxw n   � �yzy 7  � ���{|
�� 
ctxt{ o   � ����� 0 
startindex 
startIndex| o   � ����� 0 endindex endIndexz o   � ����� 0 thetext theTextx o      ���� 0 	foundtext 	foundText��  t r   � �}~} m   � � ���  ~ o      ���� 0 	foundtext 	foundTextq ��� Z  � �������� o   � �����  0 includematches includeMatches� r   � ���� K   � ��� ����
�� 
pcls� o   � ����� $0 _matchedtexttype _MatchedTextType� ������ 0 
startindex 
startIndex� o   � ����� 0 
startindex 
startIndex� ������ 0 endindex endIndex� o   � ����� 0 endindex endIndex� ������ 0 	foundtext 	foundText� o   � ����� 0 	foundtext 	foundText� ������� 0 foundgroups foundGroups� J   � �����  ��  � n      ���  ;   � �� o   � ����� 0 
resultlist 
resultList��  ��  � ��� r   � ���� [   � ���� o   � ����� 0 endindex endIndex� m   � ����� � o      ���� 0 
startindex 
startIndex� ��� r   � ���� \   � ���� [   � ���� o   � ����� 0 
startindex 
startIndex� l  � ������� n   � ���� 1   � ���
�� 
leng� n   � ���� 4   � ����
�� 
citm� o   � ����� 0 i  � o   � ����� 0 thetext theText��  ��  � m   � ����� � o      ���� 0 endindex endIndex� ��� Z   � ������� B   � ���� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� r   � ���� n   � ���� 7  � �����
�� 
ctxt� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� o   � ����� 0 thetext theText� o      ���� 0 	foundtext 	foundText��  � r   � ���� m   � ��� ���  � o      ���� 0 	foundtext 	foundText� ���� Z  �������� o   � ���� &0 includenonmatches includeNonMatches� r  ��� K  �� ����
�� 
pcls� o  	���� (0 _unmatchedtexttype _UnmatchedTextType� ������ 0 
startindex 
startIndex� o  
���� 0 
startindex 
startIndex� ������ 0 endindex endIndex� o  ���� 0 endindex endIndex� ������� 0 	foundtext 	foundText� o  ���� 0 	foundtext 	foundText��  � n      ���  ;  � o  ���� 0 
resultlist 
resultList��  ��  ��  �� 0 i  S m   j k���� T I  k r�����
�� .corecnte****       ****� n   k n��� 2  l n��
�� 
citm� o   k l���� 0 thetext theText��  ��  Q ��� r   %��� o   !���� 0 oldtids oldTIDs� n     ��� 1  "$��
�� 
txdl� 1  !"��
�� 
ascr� ���� L  &(�� o  &'���� 0 
resultlist 
resultList��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  �  -----   � ��� 
 - - - - -� ��� l     ������  �   replace text   � ���    r e p l a c e   t e x t� ��� l     ��~�}�  �~  �}  � ��� i  : =��� I      �|��{�| 0 _replacetext _replaceText� ��� o      �z�z 0 thetext theText� ��� o      �y�y 0 fortext forText� ��x� o      �w�w 0 newtext newText�x  �{  � k     &�� ��� r     ��� n    ��� 1    �v
�v 
txdl� 1     �u
�u 
ascr� o      �t�t 0 oldtids oldTIDs� ��� r    ��� o    �s�s 0 fortext forText� n     ��� 1    
�r
�r 
txdl� 1    �q
�q 
ascr� ��� l   ���� r    ��� n      2   �p
�p 
citm o    �o�o 0 thetext theText� o      �n�n 0 	textitems 	textItems� J D note: TID-based matching uses current considering/ignoring settings   � � �   n o t e :   T I D - b a s e d   m a t c h i n g   u s e s   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s�  r     o    �m�m 0 newtext newText n      1    �l
�l 
txdl 1    �k
�k 
ascr 	
	 r     c     o    �j�j 0 	textitems 	textItems m    �i
�i 
ctxt o      �h�h 0 
resulttext 
resultText
  r    # o    �g�g 0 oldtids oldTIDs n      1     "�f
�f 
txdl 1     �e
�e 
ascr �d L   $ & o   $ %�c�c 0 
resulttext 
resultText�d  �  l     �b�a�`�b  �a  �`    l     �_�^�]�_  �^  �]    l     �\�\    -----    � 
 - - - - -  !  l     �[�Z�Y�[  �Z  �Y  ! "#" i  > A$%$ I     �X&'
�X .Txt:Srchnull���     ctxt& o      �W�W 0 thetext theText' �V()
�V 
For_( o      �U�U 0 fortext forText) �T*+
�T 
Usin* |�S�R,�Q-�S  �R  , o      �P�P 0 matchformat matchFormat�Q  - l 
    .�O�N. l     /�M�L/ m      �K
�K SerECmpI�M  �L  �O  �N  + �J01
�J 
Repl0 |�I�H2�G3�I  �H  2 o      �F�F 0 newtext newText�G  3 l     4�E�D4 m      �C
�C 
msng�E  �D  1 �B5�A
�B 
Retu5 |�@�?6�>7�@  �?  6 o      �=�= 0 resultformat resultFormat�>  7 l     8�<�;8 m      �:
�: RetEMatT�<  �;  �A  % Q    �9:;9 k   �<< =>= r    ?@? n   ABA I    �9C�8�9 "0 astextparameter asTextParameterC DED o    	�7�7 0 thetext theTextE F�6F m   	 
GG �HH  �6  �8  B o    �5�5 0 _support  @ o      �4�4 0 thetext theText> IJI l   KLMK r    NON n   PQP I    �3R�2�3 "0 astextparameter asTextParameterR STS o    �1�1 0 fortext forTextT U�0U m    VV �WW  f o r�0  �2  Q o    �/�/ 0 _support  O o      �.�. 0 fortext forTextL TO DO: when matching with TIDs, optionally accept a list of multiple text values to match? (note:TIDs can do that for free, so it'd just be a case of relaxing restriction on 'for' parameter's type when pattern matching is false to accept a list of text as well); also optionally accept a corresponding list of replacement values for doing mapping? (note that map will need to be O(n) associative list in order to support considering/ignoring, although NSDictionary should be usable when matching case-sensitively)   M �XX   T O   D O :   w h e n   m a t c h i n g   w i t h   T I D s ,   o p t i o n a l l y   a c c e p t   a   l i s t   o f   m u l t i p l e   t e x t   v a l u e s   t o   m a t c h ?   ( n o t e : T I D s   c a n   d o   t h a t   f o r   f r e e ,   s o   i t ' d   j u s t   b e   a   c a s e   o f   r e l a x i n g   r e s t r i c t i o n   o n   ' f o r '   p a r a m e t e r ' s   t y p e   w h e n   p a t t e r n   m a t c h i n g   i s   f a l s e   t o   a c c e p t   a   l i s t   o f   t e x t   a s   w e l l ) ;   a l s o   o p t i o n a l l y   a c c e p t   a   c o r r e s p o n d i n g   l i s t   o f   r e p l a c e m e n t   v a l u e s   f o r   d o i n g   m a p p i n g ?   ( n o t e   t h a t   m a p   w i l l   n e e d   t o   b e   O ( n )   a s s o c i a t i v e   l i s t   i n   o r d e r   t o   s u p p o r t   c o n s i d e r i n g / i g n o r i n g ,   a l t h o u g h   N S D i c t i o n a r y   s h o u l d   b e   u s a b l e   w h e n   m a t c h i n g   c a s e - s e n s i t i v e l y )J YZY Z   3[\�-�,[ =    $]^] n    "_`_ 1     "�+
�+ 
leng` o     �*�* 0 fortext forText^ m   " #�)�)  \ R   ' /�(ab
�( .ascrerr ****      � ****a m   - .cc �dd t I n v a l i d    f o r    p a r a m e t e r   ( e x p e c t e d   o n e   o r   m o r e   c h a r a c t e r s ) .b �'ef
�' 
errne m   ) *�&�&�Yf �%g�$
�% 
erobg o   + ,�#�# 0 fortext forText�$  �-  �,  Z h�"h Z   4�ij�!ki =  4 7lml o   4 5� �  0 newtext newTextm m   5 6�
� 
msngj l  :nopn k   :qq rsr Z   : �tuvwt =  : =xyx o   : ;�� 0 resultformat resultFormaty m   ; <�
� RetEMatTu r   @ Sz{z J   @ D|| }~} m   @ A�
� boovfals~ � m   A B�
� boovtrue�  { J      �� ��� o      �� &0 includenonmatches includeNonMatches� ��� o      ��  0 includematches includeMatches�  v ��� =  V Y��� o   V W�� 0 resultformat resultFormat� m   W X�
� RetEUmaT� ��� r   \ o��� J   \ `�� ��� m   \ ]�
� boovtrue� ��� m   ] ^�
� boovfals�  � J      �� ��� o      �� &0 includenonmatches includeNonMatches� ��� o      ��  0 includematches includeMatches�  � ��� =  r u��� o   r s�� 0 resultformat resultFormat� m   s t�
� RetEAllT� ��� r   x ���� J   x |�� ��� m   x y�
� boovtrue� ��
� m   y z�	
�	 boovtrue�
  � J      �� ��� o      �� &0 includenonmatches includeNonMatches� ��� o      ��  0 includematches includeMatches�  �  w n  � ���� I   � ����� >0 throwinvalidparameterconstant throwInvalidParameterConstant� ��� o   � ��� 0 resultformat resultFormat� ��� m   � ��� ���  r e t u r n i n g�  �  � o   � ��� 0 _support  s �� � Z   ������ =  � ���� o   � ����� 0 matchformat matchFormat� m   � ���
�� SerECmpI� P   � ����� L   � ��� I   � �������� 0 	_findtext 	_findText� ��� o   � ����� 0 thetext theText� ��� o   � ����� 0 fortext forText� ��� o   � ����� &0 includenonmatches includeNonMatches� ���� o   � �����  0 includematches includeMatches��  ��  � ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ���
�� conswhit� ����
�� consnume��  � ����
�� conscase��  � ��� =  � ���� o   � ����� 0 matchformat matchFormat� m   � ���
�� SerECmpP� ��� L   � ��� I   � �������� 0 _findpattern _findPattern� ��� o   � ����� 0 thetext theText� ��� o   � ����� 0 fortext forText� ��� o   � ����� &0 includenonmatches includeNonMatches� ���� o   � �����  0 includematches includeMatches��  ��  � ��� =  � ���� o   � ����� 0 matchformat matchFormat� m   � ���
�� SerECmpC� ��� P   � ������ L   � ��� I   � �������� 0 	_findtext 	_findText� ��� o   � ����� 0 thetext theText� ��� o   � ����� 0 fortext forText� ��� o   � ����� &0 includenonmatches includeNonMatches� ���� o   � �����  0 includematches includeMatches��  ��  � ���
�� conscase� ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ���
�� conswhit� ����
�� consnume��  ��  � ��� =  � ���� o   � ����� 0 matchformat matchFormat� m   � ���
�� SerECmpD� ���� L   � ��� I   � �������� 0 	_findtext 	_findText� ��� o   � ����� 0 thetext theText� ��� o   � ����� 0 fortext forText� ��� o   � ����� &0 includenonmatches includeNonMatches� ���� o   � �����  0 includematches includeMatches��  ��  ��  � n  ��� I  ������� >0 throwinvalidparameterconstant throwInvalidParameterConstant� ��� o  ���� 0 matchformat matchFormat� ���� m  	�� ��� 
 u s i n g��  ��  � o   ���� 0 _support  �   o   find   p ��� 
   f i n d�!  k l ��� � k  �  r   n  I  ������ "0 astextparameter asTextParameter 	
	 o  ���� 0 newtext newText
 �� m   �  r e p l a c i n g   w i t h��  ��   o  ���� 0 _support   o      ���� 0 newtext newText �� Z   � =  % o   !���� 0 matchformat matchFormat m  !$��
�� SerECmpI P  (; L  1: I  19������ 0 _replacetext _replaceText  o  23���� 0 thetext theText  o  34���� 0 fortext forText �� o  45���� 0 newtext newText��  ��   ��
�� consdiac �� 
�� conshyph  ��!
�� conspunc! ��"
�� conswhit" ����
�� consnume��   ����
�� conscase��   #$# = >C%&% o  >?���� 0 matchformat matchFormat& m  ?B��
�� SerECmpP$ '(' L  FO)) I  FN��*���� "0 _replacepattern _replacePattern* +,+ o  GH���� 0 thetext theText, -.- o  HI���� 0 fortext forText. /��/ o  IJ���� 0 newtext newText��  ��  ( 010 = RW232 o  RS���� 0 matchformat matchFormat3 m  SV��
�� SerECmpC1 454 P  Zk67��6 L  aj88 I  ai��9���� 0 _replacetext _replaceText9 :;: o  bc���� 0 thetext theText; <=< o  cd���� 0 fortext forText= >��> o  de���� 0 newtext newText��  ��  7 ��?
�� conscase? ��@
�� consdiac@ ��A
�� conshyphA ��B
�� conspuncB ��C
�� conswhitC ����
�� consnume��  ��  5 DED = nsFGF o  no���� 0 matchformat matchFormatG m  or��
�� SerECmpDE H��H L  vII I  v~��J���� 0 _replacetext _replaceTextJ KLK o  wx���� 0 thetext theTextL MNM o  xy���� 0 fortext forTextN O��O o  yz���� 0 newtext newText��  ��  ��   n ��PQP I  ����R���� >0 throwinvalidparameterconstant throwInvalidParameterConstantR STS o  ������ 0 matchformat matchFormatT U��U m  ��VV �WW 
 u s i n g��  ��  Q o  ������ 0 _support  ��  �   replace     �XX    r e p l a c e�"  : R      ��YZ
�� .ascrerr ****      � ****Y o      ���� 0 etext eTextZ ��[\
�� 
errn[ o      ���� 0 enumber eNumber\ ��]^
�� 
erob] o      ���� 0 efrom eFrom^ ��_��
�� 
errt_ o      ���� 
0 eto eTo��  ; I  ���`�~� 
0 _error  ` aba m  ��cc �dd  s e a r c h   t e x tb efe o  ���}�} 0 etext eTextf ghg o  ���|�| 0 enumber eNumberh iji o  ���{�{ 0 efrom eFromj k�zk o  ���y�y 
0 eto eTo�z  �~  # lml l     �x�w�v�x  �w  �v  m non l     �u�t�s�u  �t  �s  o pqp i  B Ersr I     �rt�q
�r .Txt:EPatnull���     ctxtt o      �p�p 0 thetext theText�q  s Q     *uvwu L    xx c    yzy l   {�o�n{ n   |}| I    �m~�l�m 40 escapedpatternforstring_ escapedPatternForString_~ �k l   ��j�i� n   ��� I    �h��g�h "0 astextparameter asTextParameter� ��� o    �f�f 0 thetext theText� ��e� m    �� ���  �e  �g  � o    �d�d 0 _support  �j  �i  �k  �l  } n   ��� o    �c�c *0 nsregularexpression NSRegularExpression� m    �b
�b misccura�o  �n  z m    �a
�a 
ctxtv R      �`��
�` .ascrerr ****      � ****� o      �_�_ 0 etext eText� �^��
�^ 
errn� o      �]�] 0 enumber eNumber� �\��
�\ 
erob� o      �[�[ 0 efrom eFrom� �Z��Y
�Z 
errt� o      �X�X 
0 eto eTo�Y  w I     *�W��V�W 
0 _error  � ��� m   ! "�� ���  e s c a p e   p a t t e r n� ��� o   " #�U�U 0 etext eText� ��� o   # $�T�T 0 enumber eNumber� ��� o   $ %�S�S 0 efrom eFrom� ��R� o   % &�Q�Q 
0 eto eTo�R  �V  q ��� l     �P�O�N�P  �O  �N  � ��� l     �M�L�K�M  �L  �K  � ��� i  F I��� I     �J��I
�J .Txt:ETemnull���     ctxt� o      �H�H 0 thetext theText�I  � Q     *���� L    �� c    ��� l   ��G�F� n   ��� I    �E��D�E 60 escapedtemplateforstring_ escapedTemplateForString_� ��C� l   ��B�A� n   ��� I    �@��?�@ "0 astextparameter asTextParameter� ��� o    �>�> 0 thetext theText� ��=� m    �� ���  �=  �?  � o    �<�< 0 _support  �B  �A  �C  �D  � n   ��� o    �;�; *0 nsregularexpression NSRegularExpression� m    �:
�: misccura�G  �F  � m    �9
�9 
ctxt� R      �8��
�8 .ascrerr ****      � ****� o      �7�7 0 etext eText� �6��
�6 
errn� o      �5�5 0 enumber eNumber� �4��
�4 
erob� o      �3�3 0 efrom eFrom� �2��1
�2 
errt� o      �0�0 
0 eto eTo�1  � I     *�/��.�/ 
0 _error  � ��� m   ! "�� ���  e s c a p e   t e m p l a t e� ��� o   " #�-�- 0 etext eText� ��� o   # $�,�, 0 enumber eNumber� ��� o   $ %�+�+ 0 efrom eFrom� ��*� o   % &�)�) 
0 eto eTo�*  �.  � ��� l     �(�'�&�(  �'  �&  � ��� l     �%�$�#�%  �$  �#  � ��� l     �"���"  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     �!���!  �   Conversion Suite   � ��� "   C o n v e r s i o n   S u i t e� ��� l     � ���   �  �  � ��� i  J M��� I     ���
� .Txt:UppTnull���     ctxt� o      �� 0 thetext theText� ���
� 
Loca� |������  �  � o      �� 0 
localecode 
localeCode�  � l     ���� m      �
� 
msng�  �  �  � Q     P���� k    >�� ��� r    ��� n   ��� I    ���� 0 
asnsstring 
asNSString� ��� n   ��� I    ���� "0 astextparameter asTextParameter� ��� o    �� 0 thetext theText� ��� m    �� ���  �  �  � o    �� 0 _support  �  �  � o    �
�
 0 _support  � o      �	�	 0 
asocstring 
asocString� ��� Z    >� �� =    o    �� 0 
localecode 
localeCode m    �
� 
msng  L     ( c     ' l    %�� n    %	 I   ! %��� � "0 uppercasestring uppercaseString�  �   	 o     !���� 0 
asocstring 
asocString�  �   m   % &��
�� 
ctxt�   L   + >

 c   + = l  + ;���� n  + ; I   , ;������ 80 uppercasestringwithlocale_ uppercaseStringWithLocale_ �� l  , 7���� n  , 7 I   1 7������ *0 asnslocaleparameter asNSLocaleParameter  o   1 2���� 0 
localecode 
localeCode �� m   2 3 �  f o r   l o c a l e��  ��   o   , 1���� 0 _support  ��  ��  ��  ��   o   + ,���� 0 
asocstring 
asocString��  ��   m   ; <��
�� 
ctxt�  � R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��
�� 
errn o      ���� 0 enumber eNumber �� 
�� 
erob o      ���� 0 efrom eFrom  ��!��
�� 
errt! o      ���� 
0 eto eTo��  � I   F P��"���� 
0 _error  " #$# m   G H%% �&&  u p p e r c a s e   t e x t$ '(' o   H I���� 0 etext eText( )*) o   I J���� 0 enumber eNumber* +,+ o   J K���� 0 efrom eFrom, -��- o   K L���� 
0 eto eTo��  ��  � ./. l     ��������  ��  ��  / 010 l     ��������  ��  ��  1 232 i  N Q454 I     ��67
�� .Txt:CapTnull���     ctxt6 o      ���� 0 thetext theText7 ��8��
�� 
Loca8 |����9��:��  ��  9 o      ���� 0 
localecode 
localeCode��  : l     ;����; m      ��
�� 
msng��  ��  ��  5 Q     P<=>< k    >?? @A@ r    BCB n   DED I    ��F���� 0 
asnsstring 
asNSStringF G��G n   HIH I    ��J���� "0 astextparameter asTextParameterJ KLK o    ���� 0 thetext theTextL M��M m    NN �OO  ��  ��  I o    ���� 0 _support  ��  ��  E o    ���� 0 _support  C o      ���� 0 
asocstring 
asocStringA P��P Z    >QR��SQ =   TUT o    ���� 0 
localecode 
localeCodeU m    ��
�� 
msngR L     (VV c     'WXW l    %Y����Y n    %Z[Z I   ! %�������� &0 capitalizedstring capitalizedString��  ��  [ o     !���� 0 
asocstring 
asocString��  ��  X m   % &��
�� 
ctxt��  S L   + >\\ c   + =]^] l  + ;_����_ n  + ;`a` I   , ;��b���� <0 capitalizedstringwithlocale_ capitalizedStringWithLocale_b c��c l  , 7d����d n  , 7efe I   1 7��g���� *0 asnslocaleparameter asNSLocaleParameterg hih o   1 2���� 0 
localecode 
localeCodei j��j m   2 3kk �ll  f o r   l o c a l e��  ��  f o   , 1���� 0 _support  ��  ��  ��  ��  a o   + ,���� 0 
asocstring 
asocString��  ��  ^ m   ; <��
�� 
ctxt��  = R      ��mn
�� .ascrerr ****      � ****m o      ���� 0 etext eTextn ��op
�� 
errno o      ���� 0 enumber eNumberp ��qr
�� 
erobq o      ���� 0 efrom eFromr ��s��
�� 
errts o      ���� 
0 eto eTo��  > I   F P��t���� 
0 _error  t uvu m   G Hww �xx  c a p i t a l i z e   t e x tv yzy o   H I���� 0 etext eTextz {|{ o   I J���� 0 enumber eNumber| }~} o   J K���� 0 efrom eFrom~ �� o   K L���� 
0 eto eTo��  ��  3 ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  R U��� I     ����
�� .Txt:LowTnull���     ctxt� o      ���� 0 thetext theText� �����
�� 
Loca� |����������  ��  � o      ���� 0 
localecode 
localeCode��  � l     ������ m      ��
�� 
msng��  ��  ��  � Q     P���� k    >�� ��� r    ��� n   ��� I    ������� 0 
asnsstring 
asNSString� ���� n   ��� I    ������� "0 astextparameter asTextParameter� ��� o    ���� 0 thetext theText� ���� m    �� ���  ��  ��  � o    ���� 0 _support  ��  ��  � o    ���� 0 _support  � o      ���� 0 
asocstring 
asocString� ���� Z    >����� =   ��� o    �~�~ 0 
localecode 
localeCode� m    �}
�} 
msng� L     (�� c     '��� l    %��|�{� n    %��� I   ! %�z�y�x�z "0 lowercasestring lowercaseString�y  �x  � o     !�w�w 0 
asocstring 
asocString�|  �{  � m   % &�v
�v 
ctxt�  � L   + >�� c   + =��� l  + ;��u�t� n  + ;��� I   , ;�s��r�s 80 lowercasestringwithlocale_ lowercaseStringWithLocale_� ��q� l  , 7��p�o� n  , 7��� I   1 7�n��m�n *0 asnslocaleparameter asNSLocaleParameter� ��� o   1 2�l�l 0 
localecode 
localeCode� ��k� m   2 3�� ���  f o r   l o c a l e�k  �m  � o   , 1�j�j 0 _support  �p  �o  �q  �r  � o   + ,�i�i 0 
asocstring 
asocString�u  �t  � m   ; <�h
�h 
ctxt��  � R      �g��
�g .ascrerr ****      � ****� o      �f�f 0 etext eText� �e��
�e 
errn� o      �d�d 0 enumber eNumber� �c��
�c 
erob� o      �b�b 0 efrom eFrom� �a��`
�a 
errt� o      �_�_ 
0 eto eTo�`  � I   F P�^��]�^ 
0 _error  � ��� m   G H�� ���  l o w e r c a s e   t e x t� ��� o   H I�\�\ 0 etext eText� ��� o   I J�[�[ 0 enumber eNumber� ��� o   J K�Z�Z 0 efrom eFrom� ��Y� o   K L�X�X 
0 eto eTo�Y  �]  � ��� l     �W�V�U�W  �V  �U  � ��� l     �T�S�R�T  �S  �R  � ��� i  V Y��� I     �Q��
�Q .Txt:PadTnull���     ctxt� o      �P�P 0 thetext theText� �O��
�O 
toPl� o      �N�N 0 toplaces toPlaces� �M��
�M 
Char� |�L�K��J��L  �K  � o      �I�I 0 padchar padChar�J  � m      �� ���   � �H��G
�H 
From� |�F�E��D��F  �E  � o      �C�C 0 whichend whichEnd�D  � l     ��B�A� m      �@
�@ LeTrLCha�B  �A  �G  � k     ��� ��� l     �?���?  � � � TO DO: what if pad is multi-char? how best to align on right? e.g. if pad is ". " then ideally the periods should always appear in same columns, e.g. "foo. . ." vs "food . ."   � ���^   T O   D O :   w h a t   i f   p a d   i s   m u l t i - c h a r ?   h o w   b e s t   t o   a l i g n   o n   r i g h t ?   e . g .   i f   p a d   i s   " .   "   t h e n   i d e a l l y   t h e   p e r i o d s   s h o u l d   a l w a y s   a p p e a r   i n   s a m e   c o l u m n s ,   e . g .   " f o o .   .   . "   v s   " f o o d   .   . "� ��>� Q     ����� k    ��� ��� r    ��� n   ��� I    �=��<�= "0 astextparameter asTextParameter� ��� o    	�;�; 0 thetext theText� ��:� m   	 
�� ���  �:  �<  � o    �9�9 0 _support  � o      �8�8 0 thetext theText� � � r     n    I    �7�6�7 (0 asintegerparameter asIntegerParameter  o    �5�5 0 toplaces toPlaces �4 m    		 �

  t o   p l a c e s�4  �6   o    �3�3 0 _support   o      �2�2 0 toplaces toPlaces   r    & \    $ o     �1�1 0 toplaces toPlaces l    #�0�/ n    # 1   ! #�.
�. 
leng o     !�-�- 0 thetext theText�0  �/   o      �,�, 0 	charcount 	charCount  Z  ' 3�+�* B   ' * o   ' (�)�) 0 	charcount 	charCount m   ( )�(�(   L   - / o   - .�'�' 0 thetext theText�+  �*    r   4 A n  4 ?  I   9 ?�&!�%�& "0 astextparameter asTextParameter! "#" o   9 :�$�$ 0 padchar padChar# $�#$ m   : ;%% �&& 
 u s i n g�#  �%    o   4 9�"�" 0 _support   o      �!�! 0 padtext padText '(' Z  B V)*� �) =   B G+,+ n  B E-.- 1   C E�
� 
leng. o   B C�� 0 padtext padText, m   E F��  * R   J R�/0
� .ascrerr ****      � ****/ m   P Q11 �22 f I n v a l i d    u s i n g    p a r a m e t e r   ( e m p t y   t e x t   n o t   a l l o w e d ) .0 �34
� 
errn3 m   L M���Y4 �5�
� 
erob5 o   N O�� 0 padchar padChar�  �   �  ( 676 V   W k898 r   a f:;: b   a d<=< o   a b�� 0 padtext padText= o   b c�� 0 padtext padText; o      �� 0 padtext padText9 A   [ `>?> n  [ ^@A@ 1   \ ^�
� 
lengA o   [ \�� 0 padtext padText? o   ^ _�� 0 	charcount 	charCount7 B�B Z   l �CDEFC =  l oGHG o   l m�� 0 whichend whichEndH m   m n�
� LeTrLChaD L   r �II b   r JKJ l  r }L��L n  r }MNM 7  s }�
OP
�
 
ctxtO m   w y�	�	 P o   z |�� 0 	charcount 	charCountN o   r s�� 0 padtext padText�  �  K o   } ~�� 0 thetext theTextE QRQ =  � �STS o   � ��� 0 whichend whichEndT m   � ��
� LeTrTChaR UVU L   � �WW b   � �XYX o   � ��� 0 thetext theTextY l  � �Z��Z n  � �[\[ 7  � �� ]^
�  
ctxt] m   � ����� ^ o   � ����� 0 	charcount 	charCount\ o   � ����� 0 padtext padText�  �  V _`_ =  � �aba o   � ����� 0 whichend whichEndb m   � ���
�� LeTrBCha` c��c Z   � �de��fd =   � �ghg o   � ����� 0 	charcount 	charCounth m   � ����� e L   � �ii b   � �jkj o   � ����� 0 thetext theTextk l  � �l����l n  � �mnm 7  � ���op
�� 
ctxto m   � ����� p o   � ����� 0 	charcount 	charCountn o   � ����� 0 padtext padText��  ��  ��  f L   � �qq n  � �rsr 7  � ���tu
�� 
ctxtt m   � ����� u o   � ����� 0 toplaces toPlacess l  � �v����v b   � �wxw b   � �yzy n  � �{|{ 7  � ���}~
�� 
ctxt} m   � ����� ~ l  � ����� _   � ���� o   � ����� 0 	charcount 	charCount� m   � ����� ��  ��  | o   � ����� 0 padtext padTextz o   � ����� 0 thetext theTextx o   � ����� 0 padtext padText��  ��  ��  F n  � ���� I   � �������� >0 throwinvalidparameterconstant throwInvalidParameterConstant� ��� o   � ����� 0 whichend whichEnd� ���� m   � ��� ���  a d d i n g��  ��  � o   � ����� 0 _support  �  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I   � �������� 
0 _error  � ��� m   � ��� ���  p a d   t e x t� ��� o   � ����� 0 etext eText� ��� o   � ����� 0 enumber eNumber� ��� o   � ����� 0 efrom eFrom� ���� o   � ����� 
0 eto eTo��  ��  �>  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  Z ]��� I     ����
�� .Txt:SliTnull���     ctxt� o      ���� 0 thetext theText� ����
�� 
FIdx� |����������  ��  � o      ���� 0 
startindex 
startIndex��  � l     ������ m      ��
�� 
msng��  ��  � �����
�� 
TIdx� |����������  ��  � o      ���� 0 endindex endIndex��  � l     ������ m      ��
�� 
msng��  ��  ��  � Q    ����� k   p�� ��� r    ��� n   ��� I    ������� "0 astextparameter asTextParameter� ��� o    	���� 0 thetext theText� ���� m   	 
�� ���  ��  ��  � o    ���� 0 _support  � o      ���� 0 thetext theText� ��� r    ��� n   ��� 1    ��
�� 
leng� o    ���� 0 thetext theText� o      ���� 0 	thelength 	theLength� ��� Z    ������ >   ��� o    ���� 0 
startindex 
startIndex� m    ��
�� 
msng� k    l�� ��� r    *��� n   (��� I   " (������� (0 asintegerparameter asIntegerParameter� ��� o   " #���� 0 
startindex 
startIndex� ���� m   # $�� ���  f r o m��  ��  � o    "���� 0 _support  � o      ���� 0 
startindex 
startIndex� ��� l  + +������  � J D note: index 0 is disallowed as it makes behavior confusing to users   � ��� �   n o t e :   i n d e x   0   i s   d i s a l l o w e d   a s   i t   m a k e s   b e h a v i o r   c o n f u s i n g   t o   u s e r s� ��� Z  + =������� =   + .��� o   + ,���� 0 
startindex 
startIndex� m   , -����  � R   1 9����
�� .ascrerr ****      � ****� m   7 8�� ��� Z I n v a l i d   i n d e x   (  f r o m    p a r a m e t e r   c a n n o t   b e   0 ) .� ����
�� 
errn� m   3 4�����Y� �����
�� 
erob� o   5 6���� 0 
startindex 
startIndex��  ��  ��  � ���� Z   > l������� =  > A��� o   > ?���� 0 endindex endIndex� m   ? @��
�� 
msng� Z   D h����� A   D H��� o   D E���� 0 
startindex 
startIndex� d   E G�� o   E F���� 0 	thelength 	theLength� L   K M�� o   K L���� 0 thetext theText� ��� ?   P S��� o   P Q���� 0 
startindex 
startIndex� o   Q R���� 0 	thelength 	theLength� ���� L   V X�� m   V W�� �    ��  � L   [ h n  [ g 7  \ f��
�� 
ctxt o   ` b���� 0 
startindex 
startIndex m   c e������ o   [ \���� 0 thetext theText��  ��  ��  �  =  o r	 o   o p���� 0 endindex endIndex	 m   p q��
�� 
msng 
��
 R   u {��
�� .ascrerr ****      � **** m   y z � J M i s s i n g    f r o m    a n d / o r    t o    p a r a m e t e r . ����
�� 
errn m   w x�����[��  ��  ��  �  Z   � ���� >  � � o   � ��~�~ 0 endindex endIndex m   � ��}
�} 
msng k   � �  r   � � n  � � I   � ��|�{�| (0 asintegerparameter asIntegerParameter  o   � ��z�z 0 endindex endIndex  �y  m   � �!! �""  t o�y  �{   o   � ��x�x 0 _support   o      �w�w 0 endindex endIndex #$# Z  � �%&�v�u% =   � �'(' o   � ��t�t 0 endindex endIndex( m   � ��s�s  & R   � ��r)*
�r .ascrerr ****      � ****) m   � �++ �,, V I n v a l i d   i n d e x   (  t o    p a r a m e t e r   c a n n o t   b e   0 ) .* �q-.
�q 
errn- m   � ��p�p�Y. �o/�n
�o 
erob/ o   � ��m�m 0 endindex endIndex�n  �v  �u  $ 0�l0 Z   � �12�k�j1 =  � �343 o   � ��i�i 0 
startindex 
startIndex4 m   � ��h
�h 
msng2 Z   � �56785 A   � �9:9 o   � ��g�g 0 endindex endIndex: d   � �;; o   � ��f�f 0 	thelength 	theLength6 L   � �<< m   � �== �>>  7 ?@? ?   � �ABA o   � ��e�e 0 endindex endIndexB o   � ��d�d 0 	thelength 	theLength@ C�cC L   � �DD o   � ��b�b 0 thetext theText�c  8 L   � �EE n  � �FGF 7  � ��aHI
�a 
ctxtH m   � ��`�` I o   � ��_�_ 0 endindex endIndexG o   � ��^�^ 0 thetext theText�k  �j  �l  ��  �   JKJ l  � ��]LM�]  L + % both start and end indexes are given   M �NN J   b o t h   s t a r t   a n d   e n d   i n d e x e s   a r e   g i v e nK OPO Z  � �QR�\�[Q A   � �STS o   � ��Z�Z 0 
startindex 
startIndexT m   � ��Y�Y  R r   � �UVU [   � �WXW [   � �YZY o   � ��X�X 0 	thelength 	theLengthZ m   � ��W�W X o   � ��V�V 0 
startindex 
startIndexV o      �U�U 0 
startindex 
startIndex�\  �[  P [\[ Z  �]^�T�S] A   � �_`_ o   � ��R�R 0 endindex endIndex` m   � ��Q�Q  ^ r   � �aba [   � �cdc [   � �efe o   � ��P�P 0 	thelength 	theLengthf m   � ��O�O d o   � ��N�N 0 endindex endIndexb o      �M�M 0 endindex endIndex�T  �S  \ ghg Z .ij�L�Ki G  #klk F  mnm A  opo o  �J�J 0 
startindex 
startIndexp m  �I�I n A  qrq o  	�H�H 0 endindex endIndexr l 
	
s�G�Fs m  	
�E�E �G  �F  l F  tut ?  vwv o  �D�D 0 
startindex 
startIndexw o  �C�C 0 	thelength 	theLengthu ?  xyx o  �B�B 0 endindex endIndexy o  �A�A 0 	thelength 	theLengthj L  &*zz m  &){{ �||  �L  �K  h }~} Z  /H���@ A  /2��� o  /0�?�? 0 
startindex 
startIndex� m  01�>�> � r  58��� m  56�=�= � o      �<�< 0 
startindex 
startIndex� ��� ?  ;>��� o  ;<�;�; 0 
startindex 
startIndex� o  <=�:�: 0 	thelength 	theLength� ��9� r  AD��� o  AB�8�8 0 	thelength 	theLength� o      �7�7 0 
startindex 
startIndex�9  �@  ~ ��� Z  Ib����6� A  IL��� o  IJ�5�5 0 endindex endIndex� m  JK�4�4 � r  OR��� m  OP�3�3 � o      �2�2 0 endindex endIndex� ��� ?  UX��� o  UV�1�1 0 endindex endIndex� o  VW�0�0 0 	thelength 	theLength� ��/� r  [^��� o  [\�.�. 0 	thelength 	theLength� o      �-�- 0 endindex endIndex�/  �6  � ��,� L  cp�� n  co��� 7 dn�+��
�+ 
ctxt� o  hj�*�* 0 
startindex 
startIndex� o  km�)�) 0 endindex endIndex� o  cd�(�( 0 thetext theText�,  � R      �'��
�' .ascrerr ****      � ****� o      �&�& 0 etext eText� �%��
�% 
errn� o      �$�$ 0 enumber eNumber� �#��
�# 
erob� o      �"�" 0 efrom eFrom� �!�� 
�! 
errt� o      �� 
0 eto eTo�   � I  x����� 
0 _error  � ��� m  y|�� ���  s l i c e   t e x t� ��� o  |}�� 0 etext eText� ��� o  }~�� 0 enumber eNumber� ��� o  ~�� 0 efrom eFrom� ��� o  ��� 
0 eto eTo�  �  � ��� l     ����  �  �  � ��� l     ����  �  �  � ��� i  ^ a��� I     ���
� .Txt:TrmTnull���     ctxt� o      �� 0 thetext theText� ���
� 
From� |������  �  � o      �
�
 0 whichend whichEnd�  � l     ��	�� m      �
� LeTrBCha�	  �  �  � Q     ����� k    ��� ��� r    ��� n   ��� I    ���� "0 astextparameter asTextParameter� ��� o    	�� 0 thetext theText� ��� m   	 
�� ���  �  �  � o    �� 0 _support  � o      �� 0 thetext theText� ��� Z    -��� ��� H    �� E   ��� J    �� ��� m    ��
�� LeTrLCha� ��� m    ��
�� LeTrTCha� ���� m    ��
�� LeTrBCha��  � J    �� ���� o    ���� 0 whichend whichEnd��  � n   )��� I   # )������� >0 throwinvalidparameterconstant throwInvalidParameterConstant� ��� o   # $���� 0 whichend whichEnd� ���� m   $ %�� ���  r e m o v i n g��  ��  � o    #���� 0 _support  �   ��  � ���� P   . ����� k   3 ��� ��� l  3 ?���� Z  3 ?������� =  3 6��� o   3 4���� 0 thetext theText� m   4 5�� ���  � L   9 ;�� m   9 :�� ���  ��  ��  � H B check if theText is empty or contains white space characters only   � ��� �   c h e c k   i f   t h e T e x t   i s   e m p t y   o r   c o n t a i n s   w h i t e   s p a c e   c h a r a c t e r s   o n l y� �	 � r   @ S			 J   @ D		 			 m   @ A���� 	 	��	 m   A B��������  	 J      		 				 o      ���� 0 
startindex 
startIndex		 	
��	
 o      ���� 0 endindex endIndex��  	  			 Z   T x		����	 E  T \			 J   T X		 			 m   T U��
�� LeTrLCha	 	��	 m   U V��
�� LeTrBCha��  	 J   X [		 	��	 o   X Y���� 0 whichend whichEnd��  	 V   _ t			 r   j o			 [   j m			 o   j k���� 0 
startindex 
startIndex	 m   k l���� 	 o      ���� 0 
startindex 
startIndex	 =  c i			 n   c g		 	 4   d g��	!
�� 
cha 	! o   e f���� 0 
startindex 
startIndex	  o   c d���� 0 thetext theText	 m   g h	"	" �	#	#  ��  ��  	 	$	%	$ Z   y �	&	'����	& E  y �	(	)	( J   y }	*	* 	+	,	+ m   y z��
�� LeTrTCha	, 	-��	- m   z {��
�� LeTrBCha��  	) J   } �	.	. 	/��	/ o   } ~���� 0 whichend whichEnd��  	' V   � �	0	1	0 r   � �	2	3	2 \   � �	4	5	4 o   � ����� 0 endindex endIndex	5 m   � ����� 	3 o      ���� 0 endindex endIndex	1 =  � �	6	7	6 n   � �	8	9	8 4   � ���	:
�� 
cha 	: o   � ����� 0 endindex endIndex	9 o   � ����� 0 thetext theText	7 m   � �	;	; �	<	<  ��  ��  	% 	=��	= L   � �	>	> n   � �	?	@	? 7  � ���	A	B
�� 
ctxt	A o   � ����� 0 
startindex 
startIndex	B o   � ����� 0 endindex endIndex	@ o   � ����� 0 thetext theText��  � ��	C
�� conscase	C ��	D
�� consdiac	D ��	E
�� conshyph	E ����
�� conspunc��  � ��	F
�� consnume	F ����
�� conswhit��  ��  � R      ��	G	H
�� .ascrerr ****      � ****	G o      ���� 0 etext eText	H ��	I	J
�� 
errn	I o      ���� 0 enumber eNumber	J ��	K	L
�� 
erob	K o      ���� 0 efrom eFrom	L ��	M��
�� 
errt	M o      ���� 
0 eto eTo��  � I   � ���	N���� 
0 _error  	N 	O	P	O m   � �	Q	Q �	R	R  t r i m   t e x t	P 	S	T	S o   � ����� 0 etext eText	T 	U	V	U o   � ����� 0 enumber eNumber	V 	W	X	W o   � ����� 0 efrom eFrom	X 	Y��	Y o   � ����� 
0 eto eTo��  ��  � 	Z	[	Z l     ��������  ��  ��  	[ 	\	]	\ l     ��������  ��  ��  	] 	^	_	^ l     ��	`	a��  	` J D--------------------------------------------------------------------   	a �	b	b � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -	_ 	c	d	c l     ��	e	f��  	e   Split and Join Suite   	f �	g	g *   S p l i t   a n d   J o i n   S u i t e	d 	h	i	h l     ��������  ��  ��  	i 	j	k	j i  b e	l	m	l I      ��	n���� 0 
_splittext 
_splitText	n 	o	p	o o      ���� 0 thetext theText	p 	q��	q o      ���� 0 theseparator theSeparator��  ��  	m l    ^	r	s	t	r k     ^	u	u 	v	w	v r     	x	y	x n    
	z	{	z I    
��	|���� "0 aslistparameter asListParameter	| 	}��	} o    ���� 0 theseparator theSeparator��  ��  	{ o     ���� 0 _support  	y o      ���� 0 delimiterlist delimiterList	w 	~		~ X    C	���	�	� Q    >	�	�	�	� l    )	�	�	�	� r     )	�	�	� c     %	�	�	� n     #	�	�	� 1   ! #��
�� 
pcnt	� o     !���� 0 aref aRef	� m   # $��
�� 
ctxt	� n      	�	�	� 1   & (��
�� 
pcnt	� o   % &���� 0 aref aRef	��� caution: AS silently ignores invalid TID values, so separator items must be explicitly validated to catch any user errors; for now, just coerce to text and catch errors, but might want to make it more rigorous in future (e.g. if a list of lists is given, should sublist be treated as an error instead of just coercing it to text, which is itself TIDs sensitive); see also existing TODO on TypeSupport's asTextParameter handler   	� �	�	�V   c a u t i o n :   A S   s i l e n t l y   i g n o r e s   i n v a l i d   T I D   v a l u e s ,   s o   s e p a r a t o r   i t e m s   m u s t   b e   e x p l i c i t l y   v a l i d a t e d   t o   c a t c h   a n y   u s e r   e r r o r s ;   f o r   n o w ,   j u s t   c o e r c e   t o   t e x t   a n d   c a t c h   e r r o r s ,   b u t   m i g h t   w a n t   t o   m a k e   i t   m o r e   r i g o r o u s   i n   f u t u r e   ( e . g .   i f   a   l i s t   o f   l i s t s   i s   g i v e n ,   s h o u l d   s u b l i s t   b e   t r e a t e d   a s   a n   e r r o r   i n s t e a d   o f   j u s t   c o e r c i n g   i t   t o   t e x t ,   w h i c h   i s   i t s e l f   T I D s   s e n s i t i v e ) ;   s e e   a l s o   e x i s t i n g   T O D O   o n   T y p e S u p p o r t ' s   a s T e x t P a r a m e t e r   h a n d l e r	� R      ����	�
�� .ascrerr ****      � ****��  	� ��	���
�� 
errn	� d      	�	� m      �������  	� n  1 >	�	�	� I   6 >��	����� 60 throwinvalidparametertype throwInvalidParameterType	� 	�	�	� o   6 7���� 0 aref aRef	� 	�	�	� m   7 8	�	� �	�	�  u s i n g   s e p a r a t o r	� 	�	�	� m   8 9	�	� �	�	�  l i s t   o f   t e x t	� 	���	� m   9 :��
�� 
ctxt��  ��  	� o   1 6���� 0 _support  �� 0 aref aRef	� o    ���� 0 delimiterlist delimiterList	 	�	�	� r   D I	�	�	� n  D G	�	�	� 1   E G��
�� 
txdl	� 1   D E��
�� 
ascr	� o      ���� 0 oldtids oldTIDs	� 	�	�	� r   J O	�	�	� o   J K���� 0 delimiterlist delimiterList	� n     	�	�	� 1   L N��
�� 
txdl	� 1   K L��
�� 
ascr	� 	�	�	� r   P U	�	�	� n   P S	�	�	� 2  Q S��
�� 
citm	� o   P Q���� 0 thetext theText	� o      ���� 0 
resultlist 
resultList	� 	�	�	� r   V [	�	�	� o   V W���� 0 oldtids oldTIDs	� n     	�	�	� 1   X Z��
�� 
txdl	� 1   W X�
� 
ascr	� 	��~	� L   \ ^	�	� o   \ ]�}�} 0 
resultlist 
resultList�~  	s � � used by `split text` to split text using one or more text item delimiters and current or predefined considering/ignoring settings   	t �	�	�   u s e d   b y   ` s p l i t   t e x t `   t o   s p l i t   t e x t   u s i n g   o n e   o r   m o r e   t e x t   i t e m   d e l i m i t e r s   a n d   c u r r e n t   o r   p r e d e f i n e d   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s	k 	�	�	� l     �|�{�z�|  �{  �z  	� 	�	�	� l     �y�x�w�y  �x  �w  	� 	�	�	� i  f i	�	�	� I      �v	��u�v 0 _splitpattern _splitPattern	� 	�	�	� o      �t�t 0 thetext theText	� 	��s	� o      �r�r 0 patterntext patternText�s  �u  	� l    �	�	�	�	� k     �	�	� 	�	�	� r     	�	�	� n    	�	�	� I    �q	��p�q @0 asnsregularexpressionparameter asNSRegularExpressionParameter	� 	�	�	� o    �o�o 0 patterntext patternText	� 	�	�	� m    �n�n  	� 	��m	� m    	�	� �	�	�  a t�m  �p  	� o     �l�l 0 _support  	� o      �k�k 0 asocpattern asocPattern	� 	�	�	� r    	�	�	� n   	�	�	� I    �j	��i�j ,0 asnormalizednsstring asNormalizedNSString	� 	��h	� o    �g�g 0 thetext theText�h  �i  	� o    �f�f 0 _support  	� o      �e�e 0 
asocstring 
asocString	� 	�	�	� l   	�	�	�	� r    	�	�	� m    �d�d  	� o      �c�c &0 asocnonmatchstart asocNonMatchStart	� G A used to calculate NSRanges for non-matching portions of NSString   	� �	�	� �   u s e d   t o   c a l c u l a t e   N S R a n g e s   f o r   n o n - m a t c h i n g   p o r t i o n s   o f   N S S t r i n g	� 	�	�	� r     $	�	�	� J     "�b�b  	� o      �a�a 0 
resultlist 
resultList	� 	�	�	� l  % %�`	�	��`  	� @ : iterate over each non-matched + matched range in NSString   	� �	�	� t   i t e r a t e   o v e r   e a c h   n o n - m a t c h e d   +   m a t c h e d   r a n g e   i n   N S S t r i n g	� 	�	�	� r   % 6	�	�	� n  % 4	�	�	� I   & 4�_	��^�_ @0 matchesinstring_options_range_ matchesInString_options_range_	� 	�	�	� o   & '�]�] 0 
asocstring 
asocString	� 	�	�	� m   ' (�\�\  	� 	��[	� J   ( 0
 
  


 m   ( )�Z�Z  
 
�Y
 n  ) .


 I   * .�X�W�V�X 
0 length  �W  �V  
 o   ) *�U�U 0 
asocstring 
asocString�Y  �[  �^  	� o   % &�T�T 0 asocpattern asocPattern	� o      �S�S  0 asocmatcharray asocMatchArray	� 


 Y   7 ~
�R
	

�Q
 k   G y

 


 r   G T


 l  G R
�P�O
 n  G R


 I   M R�N
�M�N 0 rangeatindex_ rangeAtIndex_
 
�L
 m   M N�K�K  �L  �M  
 l  G M
�J�I
 n  G M


 I   H M�H
�G�H  0 objectatindex_ objectAtIndex_
 
�F
 o   H I�E�E 0 i  �F  �G  
 o   G H�D�D  0 asocmatcharray asocMatchArray�J  �I  �P  �O  
 o      �C�C  0 asocmatchrange asocMatchRange
 


 r   U \


 n  U Z


 I   V Z�B�A�@�B 0 location  �A  �@  
 o   U V�?�?  0 asocmatchrange asocMatchRange
 o      �>�>  0 asocmatchstart asocMatchStart
 
 
!
  r   ] o
"
#
" c   ] l
$
%
$ l  ] j
&�=�<
& n  ] j
'
(
' I   ^ j�;
)�:�; *0 substringwithrange_ substringWithRange_
) 
*�9
* K   ^ f
+
+ �8
,
-�8 0 location  
, o   _ `�7�7 &0 asocnonmatchstart asocNonMatchStart
- �6
.�5�6 
0 length  
. \   a d
/
0
/ o   a b�4�4  0 asocmatchstart asocMatchStart
0 o   b c�3�3 &0 asocnonmatchstart asocNonMatchStart�5  �9  �:  
( o   ] ^�2�2 0 
asocstring 
asocString�=  �<  
% m   j k�1
�1 
ctxt
# n      
1
2
1  ;   m n
2 o   l m�0�0 0 
resultlist 
resultList
! 
3�/
3 r   p y
4
5
4 [   p w
6
7
6 o   p q�.�.  0 asocmatchstart asocMatchStart
7 l  q v
8�-�,
8 n  q v
9
:
9 I   r v�+�*�)�+ 
0 length  �*  �)  
: o   q r�(�(  0 asocmatchrange asocMatchRange�-  �,  
5 o      �'�' &0 asocnonmatchstart asocNonMatchStart�/  �R 0 i  
	 m   : ;�&�&  

 \   ; B
;
<
; l  ; @
=�%�$
= n  ; @
>
?
> I   < @�#�"�!�# 	0 count  �"  �!  
? o   ; <� �   0 asocmatcharray asocMatchArray�%  �$  
< m   @ A�� �Q  
 
@
A
@ l   �
B
C�  
B "  add final non-matched range   
C �
D
D 8   a d d   f i n a l   n o n - m a t c h e d   r a n g e
A 
E
F
E r    �
G
H
G c    �
I
J
I l   �
K��
K n   �
L
M
L I   � ��
N�� *0 substringfromindex_ substringFromIndex_
N 
O�
O o   � ��� &0 asocnonmatchstart asocNonMatchStart�  �  
M o    ��� 0 
asocstring 
asocString�  �  
J m   � ��
� 
ctxt
H n      
P
Q
P  ;   � �
Q o   � ��� 0 
resultlist 
resultList
F 
R�
R L   � �
S
S o   � ��� 0 
resultlist 
resultList�  	� Q K used by `split text` to split text using a regular expression as separator   	� �
T
T �   u s e d   b y   ` s p l i t   t e x t `   t o   s p l i t   t e x t   u s i n g   a   r e g u l a r   e x p r e s s i o n   a s   s e p a r a t o r	� 
U
V
U l     ����  �  �  
V 
W
X
W l     ����  �  �  
X 
Y
Z
Y i  j m
[
\
[ I      �
]�� 0 	_jointext 	_joinText
] 
^
_
^ o      �
�
 0 thelist theList
_ 
`�	
` o      �� 0 separatortext separatorText�	  �  
\ k     >
a
a 
b
c
b r     
d
e
d n    
f
g
f 1    �
� 
txdl
g 1     �
� 
ascr
e o      �� 0 oldtids oldTIDs
c 
h
i
h r    
j
k
j o    �� 0 delimiterlist delimiterList
k n     
l
m
l 1    
�
� 
txdl
m 1    �
� 
ascr
i 
n
o
n Q    5
p
q
r
p r    
s
t
s c    
u
v
u n   
w
x
w I    �
y� � "0 aslistparameter asListParameter
y 
z��
z o    ���� 0 thelist theList��  �   
x o    ���� 0 _support  
v m    ��
�� 
ctxt
t o      ���� 0 
resulttext 
resultText
q R      ����
{
�� .ascrerr ****      � ****��  
{ ��
|��
�� 
errn
| d      
}
} m      �������  
r k   % 5
~
~ 

�
 r   % *
�
�
� o   % &���� 0 oldtids oldTIDs
� n     
�
�
� 1   ' )��
�� 
txdl
� 1   & '��
�� 
ascr
� 
���
� R   + 5��
�
�
�� .ascrerr ****      � ****
� m   3 4
�
� �
�
� b I n v a l i d   d i r e c t   p a r a m e t e r   ( e x p e c t e d   l i s t   o f   t e x t ) .
� ��
�
�
�� 
errn
� m   - .�����Y
� ��
�
�
�� 
erob
� o   / 0���� 0 thelist theList
� ��
���
�� 
errt
� m   1 2��
�� 
list��  ��  
o 
�
�
� r   6 ;
�
�
� o   6 7���� 0 oldtids oldTIDs
� n     
�
�
� 1   8 :��
�� 
txdl
� 1   7 8��
�� 
ascr
� 
���
� L   < >
�
� o   < =���� 0 
resulttext 
resultText��  
Z 
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
�  -----   
� �
�
� 
 - - - - -
� 
�
�
� l     ��������  ��  ��  
� 
�
�
� i  n q
�
�
� I     ��
�
�
�� .Txt:SplTnull���     ctxt
� o      ���� 0 thetext theText
� ��
�
�
�� 
Sepa
� |����
���
���  ��  
� o      ���� 0 theseparator theSeparator��  
� l     
�����
� m      ��
�� 
msng��  ��  
� ��
���
�� 
Usin
� |����
���
���  ��  
� o      ���� 0 matchformat matchFormat��  
� l     
�����
� m      ��
�� SerECmpI��  ��  ��  
� k     �
�
� 
�
�
� l     ��
�
���  
�rl convenience handler for splitting text using TIDs that can also use a regular expression pattern as separator; note that this is similar to using `search text theText for theSeparator returning non matching text` (except that `search text` returns start and end indexes as well as text), but avoids some of the overhead and is an obvious complement to `join text`   
� �
�
��   c o n v e n i e n c e   h a n d l e r   f o r   s p l i t t i n g   t e x t   u s i n g   T I D s   t h a t   c a n   a l s o   u s e   a   r e g u l a r   e x p r e s s i o n   p a t t e r n   a s   s e p a r a t o r ;   n o t e   t h a t   t h i s   i s   s i m i l a r   t o   u s i n g   ` s e a r c h   t e x t   t h e T e x t   f o r   t h e S e p a r a t o r   r e t u r n i n g   n o n   m a t c h i n g   t e x t `   ( e x c e p t   t h a t   ` s e a r c h   t e x t `   r e t u r n s   s t a r t   a n d   e n d   i n d e x e s   a s   w e l l   a s   t e x t ) ,   b u t   a v o i d s   s o m e   o f   t h e   o v e r h e a d   a n d   i s   a n   o b v i o u s   c o m p l e m e n t   t o   ` j o i n   t e x t `
� 
���
� Q     �
�
�
�
� k    }
�
� 
�
�
� r    
�
�
� n   
�
�
� I    ��
����� "0 astextparameter asTextParameter
� 
�
�
� o    	���� 0 thetext theText
� 
���
� m   	 

�
� �
�
�  ��  ��  
� o    ���� 0 _support  
� o      ���� 0 thetext theText
� 
���
� Z    }
�
�
�
�
� =   
�
�
� o    ���� 0 theseparator theSeparator
� m    ��
�� 
msng
� l   
�
�
�
� L    
�
� I    ��
����� 0 _splitpattern _splitPattern
� 
�
�
� o    ���� 0 thetext theText
� 
���
� m    
�
� �
�
�  \ s +��  ��  
� g a if `at` parameter is omitted, splits on whitespace runs by default, ignoring any `using` options   
� �
�
� �   i f   ` a t `   p a r a m e t e r   i s   o m i t t e d ,   s p l i t s   o n   w h i t e s p a c e   r u n s   b y   d e f a u l t ,   i g n o r i n g   a n y   ` u s i n g `   o p t i o n s
� 
�
�
� =  " %
�
�
� o   " #���� 0 matchformat matchFormat
� m   # $��
�� SerECmpI
� 
�
�
� P   ( 6
�
�
�
� L   - 5
�
� I   - 4��
����� 0 
_splittext 
_splitText
� 
�
�
� o   . /���� 0 thetext theText
� 
���
� o   / 0���� 0 theseparator theSeparator��  ��  
� ��
�
�� consdiac
� ��
�
�� conshyph
� ��
�
�� conspunc
� ��
�
�� conswhit
� ����
�� consnume��  
� ����
�� conscase��  
� 
�
�
� =  9 <
�
�
� o   9 :���� 0 matchformat matchFormat
� m   : ;��
�� SerECmpP
� 
�
�
� L   ? G
�
� I   ? F��
����� 0 _splitpattern _splitPattern
� 
�
�
� o   @ A���� 0 thetext theText
� 
���
� o   A B���� 0 theseparator theSeparator��  ��  
� 
�
�
� =  J M
�
�
� o   J K���� 0 matchformat matchFormat
� m   K L��
�� SerECmpC
� 
�
�
� P   P ^
�
���
� L   U ]
�
� I   U \�� ���� 0 
_splittext 
_splitText   o   V W���� 0 thetext theText �� o   W X���� 0 theseparator theSeparator��  ��  
� ��
�� conscase ��
�� consdiac ��
�� conshyph ��
�� conspunc ��
�� conswhit ����
�� consnume��  ��  
� 	
	 =  a d o   a b���� 0 matchformat matchFormat m   b c��
�� SerECmpD
 �� L   g o I   g n������ 0 
_splittext 
_splitText  o   h i���� 0 thetext theText �� o   i j���� 0 theseparator theSeparator��  ��  ��  
� n  r } I   w }������ >0 throwinvalidparameterconstant throwInvalidParameterConstant  o   w x���� 0 matchformat matchFormat �� m   x y � 
 u s i n g��  ��   o   r w���� 0 _support  ��  
� R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��
�� 
errn o      ���� 0 enumber eNumber �� 
�� 
erob o      ���� 0 efrom eFrom  ��!�
�� 
errt! o      �~�~ 
0 eto eTo�  
� I   � ��}"�|�} 
0 _error  " #$# m   � �%% �&&  s p l i t   t e x t$ '(' o   � ��{�{ 0 etext eText( )*) o   � ��z�z 0 enumber eNumber* +,+ o   � ��y�y 0 efrom eFrom, -�x- o   � ��w�w 
0 eto eTo�x  �|  ��  
� ./. l     �v�u�t�v  �u  �t  / 010 l     �s�r�q�s  �r  �q  1 232 i  r u454 I     �p67
�p .Txt:JoiTnull���     ****6 o      �o�o 0 thelist theList7 �n8�m
�n 
Sepa8 |�l�k9�j:�l  �k  9 o      �i�i 0 separatortext separatorText�j  : m      ;; �<<  �m  5 Q     '=>?= L    @@ I    �hA�g�h 0 	_jointext 	_joinTextA BCB o    �f�f 0 thelist theListC D�eD n   EFE I   
 �dG�c�d "0 astextparameter asTextParameterG HIH o   
 �b�b 0 separatortext separatorTextI J�aJ m    KK �LL  u s i n g   s e p a r a t o r�a  �c  F o    
�`�` 0 _support  �e  �g  > R      �_MN
�_ .ascrerr ****      � ****M o      �^�^ 0 etext eTextN �]OP
�] 
errnO o      �\�\ 0 enumber eNumberP �[QR
�[ 
erobQ o      �Z�Z 0 efrom eFromR �YS�X
�Y 
errtS o      �W�W 
0 eto eTo�X  ? I    '�VT�U�V 
0 _error  T UVU m    WW �XX  j o i n   t e x tV YZY o     �T�T 0 etext eTextZ [\[ o     !�S�S 0 enumber eNumber\ ]^] o   ! "�R�R 0 efrom eFrom^ _�Q_ o   " #�P�P 
0 eto eTo�Q  �U  3 `a` l     �O�N�M�O  �N  �M  a bcb l     �L�K�J�L  �K  �J  c ded i  v yfgf I     �Ih�H
�I .Txt:SplPnull���     ctxth o      �G�G 0 thetext theText�H  g Q     $ijki L    ll n    mnm 2   �F
�F 
cparn n   opo I    �Eq�D�E "0 astextparameter asTextParameterq rsr o    	�C�C 0 thetext theTexts t�Bt m   	 
uu �vv  �B  �D  p o    �A�A 0 _support  j R      �@wx
�@ .ascrerr ****      � ****w o      �?�? 0 etext eTextx �>yz
�> 
errny o      �=�= 0 enumber eNumberz �<{|
�< 
erob{ o      �;�; 0 efrom eFrom| �:}�9
�: 
errt} o      �8�8 
0 eto eTo�9  k I    $�7~�6�7 
0 _error  ~ � m    �� ���   s p l i t   p a r a g r a p h s� ��� o    �5�5 0 etext eText� ��� o    �4�4 0 enumber eNumber� ��� o    �3�3 0 efrom eFrom� ��2� o     �1�1 
0 eto eTo�2  �6  e ��� l     �0�/�.�0  �/  �.  � ��� l     �-�,�+�-  �,  �+  � ��� i  z }��� I     �*��
�* .Txt:JoiPnull���     ****� o      �)�) 0 thelist theList� �(��'
�( 
LiBr� |�&�%��$��&  �%  � o      �#�# 0 linebreaktype lineBreakType�$  � l     ��"�!� m      � 
�  LiBrLiOX�"  �!  �'  � Q     O���� k    =�� ��� Z    4����� =   ��� o    �� 0 linebreaktype lineBreakType� m    �
� LiBrLiOX� r   	 ��� 1   	 
�
� 
lnfd� o      �� 0 separatortext separatorText� ��� =   ��� o    �� 0 linebreaktype lineBreakType� m    �
� LiBrLiCM� ��� r    ��� o    �
� 
ret � o      �� 0 separatortext separatorText� ��� =   ��� o    �� 0 linebreaktype lineBreakType� m    �
� LiBrLiWi� ��� r   ! &��� b   ! $��� o   ! "�
� 
ret � 1   " #�
� 
lnfd� o      �� 0 separatortext separatorText�  � n  ) 4��� I   . 4���� >0 throwinvalidparameterconstant throwInvalidParameterConstant� ��� o   . /�� 0 linebreaktype lineBreakType� ��� m   / 0�� ��� 
 u s i n g�  �  � o   ) .�� 0 _support  � ��� L   5 =�� I   5 <���
� 0 	_jointext 	_joinText� ��� o   6 7�	�	 0 thelist theList� ��� o   7 8�� 0 separatortext separatorText�  �
  �  � R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� � ���
�  
errt� o      ���� 
0 eto eTo��  � I   E O������� 
0 _error  � ��� m   F G�� ���  j o i n   p a r a g r a p h s� ��� o   G H���� 0 etext eText� ��� o   H I���� 0 enumber eNumber� ��� o   I J���� 0 efrom eFrom� ���� o   J K���� 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  �   formatting   � ���    f o r m a t t i n g� ��� l     ��������  ��  ��  � ��� i  ~ ���� I      ������� (0 _makevalueiterator _makeValueIterator� ���� o      ���� 0 
objectlist 
objectList��  ��  � h     ����� 0 scpt  � k      �� ��� j     ����� 0 _objects  � c     ��� o     ���� 0 
objectlist 
objectList� m    ��
�� 
list� ��� j   	 ����� 0 i  � m   	 
����  � ���� i    ��� I     ������
�� .aevtoappnull  �   � ****��  ��  � k     7�� ��� r        [      o     ���� 0 i   m    ����  o      ���� 0 i  �  l   ( Z   (	
����	 ?     o    ���� 0 i   n     1    ��
�� 
leng o    ���� 0 _objects  
 R    $����
�� .ascrerr ****      � ****��   ����
�� 
errn m     !�������  ��  ��     stop iteration    �    s t o p   i t e r a t i o n �� L   ) 7 n   ) 6 4   . 5��
�� 
cobj o   / 4���� 0 i   o   ) .���� 0 _objects  ��  ��  �  l     ��������  ��  ��    l     ����    -----    � 
 - - - - -  l     ��������  ��  ��    !  i  � �"#" I     ����$
�� .Txt:FLitnull��� ��� null��  $ ��%��
�� 
For_% o      ���� 0 thevalue theValue��  # k    _&& '(' l      ��)*��  )�� Notes:
	 
	 - Most value types can be rendered using vanilla code; only specifiers and records have to be rendered via OSA APIs; values should be rendered in human-readable form (text isn't quoted, lists are concatentated as comma-separated items, dates and numbers using default AS coercions, etc) - user can use `literal representation`, `format number/date`, etc. to format values differently (avoids need for complex template parsing).
	 
	- Rendering arbitrary AS values requires wrapping the value in a script object (to preserve context info such as an object specifier's target application), converting that script to a typeScript descriptor (e.g. by packing it into an Apple event and sending it to a previously installed AE handler), then loading that script into an AS component instance, executing it, and returning the result's display value. Currently this is done via TextSupport.app agent. The whole thing's ridiculously kludgy, currently isn't smart enough to load up appropriate terminology before rendering app specifiers, and really requires AppleScript to implement a proper `literal text` property on all its datatypes. But at least it should help demonstrate the need for such a feature.
	   * �++	z   N o t e s : 
 	   
 	   -   M o s t   v a l u e   t y p e s   c a n   b e   r e n d e r e d   u s i n g   v a n i l l a   c o d e ;   o n l y   s p e c i f i e r s   a n d   r e c o r d s   h a v e   t o   b e   r e n d e r e d   v i a   O S A   A P I s ;   v a l u e s   s h o u l d   b e   r e n d e r e d   i n   h u m a n - r e a d a b l e   f o r m   ( t e x t   i s n ' t   q u o t e d ,   l i s t s   a r e   c o n c a t e n t a t e d   a s   c o m m a - s e p a r a t e d   i t e m s ,   d a t e s   a n d   n u m b e r s   u s i n g   d e f a u l t   A S   c o e r c i o n s ,   e t c )   -   u s e r   c a n   u s e   ` l i t e r a l   r e p r e s e n t a t i o n ` ,   ` f o r m a t   n u m b e r / d a t e ` ,   e t c .   t o   f o r m a t   v a l u e s   d i f f e r e n t l y   ( a v o i d s   n e e d   f o r   c o m p l e x   t e m p l a t e   p a r s i n g ) . 
 	   
 	 -   R e n d e r i n g   a r b i t r a r y   A S   v a l u e s   r e q u i r e s   w r a p p i n g   t h e   v a l u e   i n   a   s c r i p t   o b j e c t   ( t o   p r e s e r v e   c o n t e x t   i n f o   s u c h   a s   a n   o b j e c t   s p e c i f i e r ' s   t a r g e t   a p p l i c a t i o n ) ,   c o n v e r t i n g   t h a t   s c r i p t   t o   a   t y p e S c r i p t   d e s c r i p t o r   ( e . g .   b y   p a c k i n g   i t   i n t o   a n   A p p l e   e v e n t   a n d   s e n d i n g   i t   t o   a   p r e v i o u s l y   i n s t a l l e d   A E   h a n d l e r ) ,   t h e n   l o a d i n g   t h a t   s c r i p t   i n t o   a n   A S   c o m p o n e n t   i n s t a n c e ,   e x e c u t i n g   i t ,   a n d   r e t u r n i n g   t h e   r e s u l t ' s   d i s p l a y   v a l u e .   C u r r e n t l y   t h i s   i s   d o n e   v i a   T e x t S u p p o r t . a p p   a g e n t .   T h e   w h o l e   t h i n g ' s   r i d i c u l o u s l y   k l u d g y ,   c u r r e n t l y   i s n ' t   s m a r t   e n o u g h   t o   l o a d   u p   a p p r o p r i a t e   t e r m i n o l o g y   b e f o r e   r e n d e r i n g   a p p   s p e c i f i e r s ,   a n d   r e a l l y   r e q u i r e s   A p p l e S c r i p t   t o   i m p l e m e n t   a   p r o p e r   ` l i t e r a l   t e x t `   p r o p e r t y   o n   a l l   i t s   d a t a t y p e s .   B u t   a t   l e a s t   i t   s h o u l d   h e l p   d e m o n s t r a t e   t h e   n e e d   f o r   s u c h   a   f e a t u r e . 
 	( ,��, P    _-./- Q   ^0120 k   H33 454 l   ��67��  6 � z caution: AS types that can have overridden `class` properties (specifiers, records, etc) must be handled as special cases   7 �88 �   c a u t i o n :   A S   t y p e s   t h a t   c a n   h a v e   o v e r r i d d e n   ` c l a s s `   p r o p e r t i e s   ( s p e c i f i e r s ,   r e c o r d s ,   e t c )   m u s t   b e   h a n d l e d   a s   s p e c i a l   c a s e s5 9:9 Z   �;<����; F    3=>= F    #?@? =    ABA l   C����C I   ��DE
�� .corecnte****       ****D J    FF G��G o    	���� 0 thevalue theValue��  E ��H��
�� 
koclH m    ��
�� 
obj ��  ��  ��  B m    ����  @ =    !IJI l   K����K I   ��LM
�� .corecnte****       ****L J    NN O��O o    ���� 0 thevalue theValue��  M ��P��
�� 
koclP m    ��
�� 
capp��  ��  ��  J m     ����  > =   & 1QRQ l  & /S����S I  & /��TU
�� .corecnte****       ****T J   & )VV W��W o   & '���� 0 thevalue theValue��  U ��X��
�� 
koclX m   * +��
�� 
reco��  ��  ��  R m   / 0����  < Z   6�YZ[\Y >   6 A]^] l  6 ?_����_ I  6 ?��`a
�� .corecnte****       ****` J   6 9bb c��c o   6 7���� 0 thevalue theValue��  a ��d��
�� 
kocld m   : ;��
�� 
scpt��  ��  ��  ^ m   ? @����  Z l  D Yefge Q   D Yhijh L   G Okk b   G Nlml b   G Lnon m   G Hpp �qq  � s c r i p t  o l  H Kr����r n  H Ksts 1   I K��
�� 
pnamt o   H I���� 0 thevalue theValue��  ��  m m   L Muu �vv  �i R      ������
�� .ascrerr ****      � ****��  ��  j L   W Yww m   W Xxx �yy  � s c r i p t �fGA script objects are currently displayed as "�script[NAME]�" (displaying script objects as source code is a separate task and should be done via OSAKit/osadecompile); TO DO: support informal 'description' protocol, speculatively calling `theValue's objectDescription()` and returning result if it's a non-empty text value?   g �zz�   s c r i p t   o b j e c t s   a r e   c u r r e n t l y   d i s p l a y e d   a s   " � s c r i p t [ N A M E ] � "   ( d i s p l a y i n g   s c r i p t   o b j e c t s   a s   s o u r c e   c o d e   i s   a   s e p a r a t e   t a s k   a n d   s h o u l d   b e   d o n e   v i a   O S A K i t / o s a d e c o m p i l e ) ;   T O   D O :   s u p p o r t   i n f o r m a l   ' d e s c r i p t i o n '   p r o t o c o l ,   s p e c u l a t i v e l y   c a l l i n g   ` t h e V a l u e ' s   o b j e c t D e s c r i p t i o n ( ) `   a n d   r e t u r n i n g   r e s u l t   i f   i t ' s   a   n o n - e m p t y   t e x t   v a l u e ?[ {|{ =  \ c}~} n  \ _� m   ] _��
�� 
pcls� o   \ ]���� 0 thevalue theValue~ m   _ b��
�� 
ctxt| ��� k   f ��� ��� r   f o��� n  f m��� 1   i m��
�� 
txdl� 1   f i��
�� 
ascr� o      ���� 0 oldtids oldTIDs� ��� r   p {��� m   p s�� ���  \� n     ��� 1   v z��
�� 
txdl� 1   s v��
�� 
ascr� ��� r   | ���� n   | ���� 2  } ���
�� 
citm� o   | }���� 0 thevalue theValue� o      ���� 0 	textitems 	textItems� ��� r   � ���� m   � ��� ���  \ \� n     ��� 1   � ���
�� 
txdl� 1   � ���
�� 
ascr� ��� r   � ���� c   � ���� o   � ����� 0 	textitems 	textItems� m   � ��
� 
ctxt� o      �~�~ 0 thevalue theValue� ��� r   � ���� m   � ��� ���  "� n     ��� 1   � ��}
�} 
txdl� 1   � ��|
�| 
ascr� ��� r   � ���� n   � ���� 2  � ��{
�{ 
citm� o   � ��z�z 0 thevalue theValue� o      �y�y 0 	textitems 	textItems� ��� r   � ���� m   � ��� ���  \ "� n     ��� 1   � ��x
�x 
txdl� 1   � ��w
�w 
ascr� ��� r   � ���� c   � ���� o   � ��v�v 0 	textitems 	textItems� m   � ��u
�u 
ctxt� o      �t�t 0 thevalue theValue� ��� r   � ���� o   � ��s�s 0 oldtids oldTIDs� n     ��� 1   � ��r
�r 
txdl� 1   � ��q
�q 
ascr� ��p� L   � ��� b   � ���� b   � ���� m   � ��� ���  "� o   � ��o�o 0 thevalue theValue� m   � ��� ���  "�p  � ��� =  � ���� n  � ���� m   � ��n
�n 
pcls� o   � ��m�m 0 thevalue theValue� m   � ��l
�l 
optr� ��k� l  �v���� k   �v�� ��� l  � ��j���j  � f ` TO DO: this is kludgy; ought to be possible to load AEDesc into an OSAValueID then display that   � ��� �   T O   D O :   t h i s   i s   k l u d g y ;   o u g h t   t o   b e   p o s s i b l e   t o   l o a d   A E D e s c   i n t o   a n   O S A V a l u e I D   t h e n   d i s p l a y   t h a t� ��� Q   �k���� k   �^�� ��� r   � ���� n  � ���� I   � ��i��h�i  0 objectatindex_ objectAtIndex_� ��g� m   � ��f�f  �g  �h  � l  � ���e�d� n  � ���� I   � ��c��b�c $0 arraywithobject_ arrayWithObject_� ��a� o   � ��`�` 0 thevalue theValue�a  �b  � n  � ���� o   � ��_�_ 0 nsarray NSArray� m   � ��^
�^ misccura�e  �d  � o      �]�]  0 asocdescriptor asocDescriptor� ��� r   ���� c   ���� l  ���\�[� n  ���� I   ��Z �Y�Z ,0 asnormalizednsstring asNormalizedNSString  �X n  �
 I  
�W�V�U�W "0 uppercasestring uppercaseString�V  �U   l  ��T�S n  � I  �R�Q�P�R 0 description  �Q  �P   n  � I   ��O�N�M�O 0 data  �N  �M   o   � ��L�L  0 asocdescriptor asocDescriptor�T  �S  �X  �Y  � o   � ��K�K 0 _support  �\  �[  � m  �J
�J 
ctxt� o      �I�I 0 hextext hexText� 	
	 r   n  1  �H
�H 
txdl 1  �G
�G 
ascr o      �F�F 0 oldtids oldTIDs
  r  * 1  "�E
�E 
spac n      1  %)�D
�D 
txdl 1  "%�C
�C 
ascr  r  +2 n  +0 2 ,0�B
�B 
citm o  +,�A�A 0 hextext hexText o      �@�@ 0 	textitems 	textItems  r  3> m  36 �     n     !"! 1  9=�?
�? 
txdl" 1  69�>
�> 
ascr #$# r  ?T%&% n ?R'(' 7 DR�=)*
�= 
ctxt) m  JL�<�< * m  MQ�;�;��( l ?D+�:�9+ c  ?D,-, o  ?@�8�8 0 	textitems 	textItems- m  @C�7
�7 
ctxt�:  �9  & o      �6�6 0 hextext hexText$ .�5. r  U^/0/ o  UV�4�4 0 oldtids oldTIDs0 n     121 1  Y]�3
�3 
txdl2 1  VY�2
�2 
ascr�5  � R      �1�0�/
�1 .ascrerr ****      � ****�0  �/  � r  fk343 m  fi55 �66  &4 o      �.�. 0 hextext hexText� 7�-7 L  lv88 b  lu9:9 b  lq;<; m  lo== �>>  � d a t a   o p t r< o  op�,�, 0 hextext hexText: m  qt?? �@@  ��-  �   format "�data optr...�"   � �AA 0   f o r m a t   " � d a t a   o p t r . . . � "�k  \ Q  y�BCDB L  |�EE c  |�FGF o  |}�+�+ 0 thevalue theValueG m  }��*
�* 
ctxtC R      �)�(H
�) .ascrerr ****      � ****�(  H �'I�&
�' 
errnI d      JJ m      �%�%��&  D l ���$KL�$  K   fall through   L �MM    f a l l   t h r o u g h��  ��  : NON l ���#PQ�#  P � � if it's an ASOC object specifier, use object's description if available otherwise create raw syntax representation of ocid specifier   Q �RR
   i f   i t ' s   a n   A S O C   o b j e c t   s p e c i f i e r ,   u s e   o b j e c t ' s   d e s c r i p t i o n   i f   a v a i l a b l e   o t h e r w i s e   c r e a t e   r a w   s y n t a x   r e p r e s e n t a t i o n   o f   o c i d   s p e c i f i e rO STS Z  �UV�"�!U F  ��WXW >  ��YZY l ��[� �[ I ���\]
� .corecnte****       ****\ J  ��^^ _�_ o  ���� 0 thevalue theValue�  ] �`�
� 
kocl` m  ���
� 
obj �  �   �  Z m  ����  X = ��aba n ��cdc m  ���
� 
wantd l ��e��e c  ��fgf o  ���� 0 thevalue theValueg m  ���
� 
reco�  �  b m  ���
� 
ocidV l �hijh Q  �klmk k  ��nn opo r  ��qrq l ��s��s c  ��tut n ��vwv I  ������ 0 description  �  �  w o  ���� 0 thevalue theValueu m  ���
� 
ctxt�  �  r o      �
�
 "0 descriptiontext descriptionTextp xyx Z ��z{�	�z F  ��|}| C  ��~~ o  ���� "0 descriptiontext descriptionText m  ���� ���  <} D  ����� o  ���� "0 descriptiontext descriptionText� m  ���� ���  >{ r  ����� n  ����� 7 �����
� 
ctxt� m  ���� � m  ������� o  ���� "0 descriptiontext descriptionText� o      �� "0 descriptiontext descriptionText�	  �  y �� � L  ���� b  ����� b  ����� m  ���� ���  �� o  ������ "0 descriptiontext descriptionText� m  ���� ���  ��   l R      ������
�� .ascrerr ****      � ****��  ��  m l ����� l ����� L  ��� b  �
��� m  ���� ���   � c l a s s   o c i d �   i d  � l �	������ I �	�����
�� .Txt:FLitnull��� ��� null��  � �����
�� 
For_� l ������� n ���� m  ��
�� 
seld� l ������� c  ���� o  ������ 0 thevalue theValue� m  � ��
�� 
reco��  ��  ��  ��  ��  ��  ��  � � � would be better to get correct representation generated by OSAKit, but AS doesn't allow ASOC specifiers to travel so string-munging it is   � ���   w o u l d   b e   b e t t e r   t o   g e t   c o r r e c t   r e p r e s e n t a t i o n   g e n e r a t e d   b y   O S A K i t ,   b u t   A S   d o e s n ' t   a l l o w   A S O C   s p e c i f i e r s   t o   t r a v e l   s o   s t r i n g - m u n g i n g   i t   i s� V P otherwise use raw ASOC object specifier syntax (not ideal, but will have to do)   � ��� �   o t h e r w i s e   u s e   r a w   A S O C   o b j e c t   s p e c i f i e r   s y n t a x   ( n o t   i d e a l ,   b u t   w i l l   h a v e   t o   d o )i � �  (see Objects library's `check type` handler for notes)		-- TO DO: need to check this hack (it's also used in Objects) as it's possible it will error on some reference objects (e.g. app specifiers)   j ����     ( s e e   O b j e c t s   l i b r a r y ' s   ` c h e c k   t y p e `   h a n d l e r   f o r   n o t e s ) 	 	 - -   T O   D O :   n e e d   t o   c h e c k   t h i s   h a c k   ( i t ' s   a l s o   u s e d   i n   O b j e c t s )   a s   i t ' s   p o s s i b l e   i t   w i l l   e r r o r   o n   s o m e   r e f e r e n c e   o b j e c t s   ( e . g .   a p p   s p e c i f i e r s )�"  �!  T ��� l ������  �hb TO DO: there's a problem here if value is a record containing ASOC specifiers, as there's no practical way to examine the record's properties without sending it to an AE handler, and AS will throw an error; suspect the only practical option is to throw another error that describes the problem, or return "�record�" to indicate object is unrepresentable   � ����   T O   D O :   t h e r e ' s   a   p r o b l e m   h e r e   i f   v a l u e   i s   a   r e c o r d   c o n t a i n i n g   A S O C   s p e c i f i e r s ,   a s   t h e r e ' s   n o   p r a c t i c a l   w a y   t o   e x a m i n e   t h e   r e c o r d ' s   p r o p e r t i e s   w i t h o u t   s e n d i n g   i t   t o   a n   A E   h a n d l e r ,   a n d   A S   w i l l   t h r o w   a n   e r r o r ;   s u s p e c t   t h e   o n l y   p r a c t i c a l   o p t i o n   i s   t o   t h r o w   a n o t h e r   e r r o r   t h a t   d e s c r i b e s   t h e   p r o b l e m ,   o r   r e t u r n   " � r e c o r d � "   t o   i n d i c a t e   o b j e c t   i s   u n r e p r e s e n t a b l e� ���� Q  H���� k  <�� ��� r  ��� I  ������� (0 _makevalueiterator _makeValueIterator� ���� J  �� ���� o  ���� 0 thevalue theValue��  ��  ��  � o      ���� 0 scpt  � ���� O  <��� I ,;�����
�� .Txt:LitR****      � ****��  � ����
�� 
Scpt� o  01���� 0 scpt  � �����
�� 
Deco� l 45������ m  45��
�� boovfals��  ��  ��  � 5  )�����
�� 
capp� o   %���� 60 _textsupportagentbundleid _TextSupportAgentBundleID
�� kfrmID  ��  � R      ������
�� .ascrerr ****      � ****��  ��  � L  DH�� m  DG�� ��� 0 � u n r e p r e s e n t a b l e   o b j e c t ���  1 R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  2 l P^���� I  P^������� 
0 _error  � ��� m  QT�� ��� , l i t e r a l   r e p r e s e n t a t i o n� ��� o  TU���� 0 etext eText� ��� o  UV���� 0 enumber eNumber� ��� o  VW���� 0 efrom eFrom� ���� o  WX���� 
0 eto eTo��  ��  � 8 2 note: this handler should never fail, caveat bugs   � ��� d   n o t e :   t h i s   h a n d l e r   s h o u l d   n e v e r   f a i l ,   c a v e a t   b u g s. ���
�� conscase� ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ����
�� conswhit��  / ����
�� consnume��  ��  ! ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I     ����
�� .Txt:FTxtnull���     ctxt� o      ���� 0 templatetext templateText� �����
�� 
Usin� o      ���� 0 	thevalues 	theValues��  � k    3�� ��� l     ������  � � � note: templateText uses same `$n` (where n=1-9) notation as `search text`'s replacement templates, with `\$` to escape as necessary ($ not followed by a digit will appear as-is)   � ���d   n o t e :   t e m p l a t e T e x t   u s e s   s a m e   ` $ n `   ( w h e r e   n = 1 - 9 )   n o t a t i o n   a s   ` s e a r c h   t e x t ` ' s   r e p l a c e m e n t   t e m p l a t e s ,   w i t h   ` \ $ `   t o   e s c a p e   a s   n e c e s s a r y   ( $   n o t   f o l l o w e d   b y   a   d i g i t   w i l l   a p p e a r   a s - i s )� ���� Q    3���� k   �� ��� r    ��� n      I    ������ "0 aslistparameter asListParameter �� o    	���� 0 	thevalues 	theValues��  ��   o    ���� 0 _support  � o      ���� 0 	thevalues 	theValues�  r     n   	 I    ��
���� Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_
  m     �  \ \ . | \ $ [ 1 - 9 ]  m    ����   �� l   ���� m    ��
�� 
msng��  ��  ��  ��  	 n    o    ���� *0 nsregularexpression NSRegularExpression m    ��
�� misccura o      ���� 0 asocpattern asocPattern  r    ) n   ' I   " '������ 0 
asnsstring 
asNSString �� o   " #���� 0 templatetext templateText��  ��   o    "���� 0 _support   o      ���� 0 
asocstring 
asocString  r   * ;  l  * 9!����! n  * 9"#" I   + 9��$���� @0 matchesinstring_options_range_ matchesInString_options_range_$ %&% o   + ,���� 0 
asocstring 
asocString& '(' m   , -����  ( )��) J   - 5** +,+ m   - .����  , -��- n  . 3./. I   / 3�������� 
0 length  ��  ��  / o   . /���� 0 
asocstring 
asocString��  ��  ��  # o   * +���� 0 asocpattern asocPattern��  ��    o      ����  0 asocmatcharray asocMatchArray 010 r   < @232 J   < >����  3 o      ���� 0 resulttexts resultTexts1 454 r   A D676 m   A B����  7 o      ���� 0 
startindex 
startIndex5 8��8 P   E9:;9 k   J<< =>= Y   J �?��@A��? k   Z �BB CDC r   Z gEFE l  Z eG����G n  Z eHIH I   ` e��J���� 0 rangeatindex_ rangeAtIndex_J K��K m   ` a����  ��  ��  I l  Z `L��~L n  Z `MNM I   [ `�}O�|�}  0 objectatindex_ objectAtIndex_O P�{P o   [ \�z�z 0 i  �{  �|  N o   Z [�y�y  0 asocmatcharray asocMatchArray�  �~  ��  ��  F o      �x�x 0 
matchrange 
matchRangeD QRQ r   h �STS c   h }UVU l  h yW�w�vW n  h yXYX I   i y�uZ�t�u *0 substringwithrange_ substringWithRange_Z [�s[ K   i u\\ �r]^�r 0 location  ] o   j k�q�q 0 
startindex 
startIndex^ �p_�o�p 
0 length  _ l  l s`�n�m` \   l saba l  l qc�l�kc n  l qded I   m q�j�i�h�j 0 location  �i  �h  e o   l m�g�g 0 
matchrange 
matchRange�l  �k  b o   q r�f�f 0 
startindex 
startIndex�n  �m  �o  �s  �t  Y o   h i�e�e 0 
asocstring 
asocString�w  �v  V m   y |�d
�d 
ctxtT n      fgf  ;   ~ g o   } ~�c�c 0 resulttexts resultTextsR hih r   � �jkj c   � �lml l  � �n�b�an n  � �opo I   � ��`q�_�` *0 substringwithrange_ substringWithRange_q r�^r o   � ��]�] 0 
matchrange 
matchRange�^  �_  p o   � ��\�\ 0 
asocstring 
asocString�b  �a  m m   � ��[
�[ 
ctxtk o      �Z�Z 0 thetoken theTokeni sts Z   � �uv�Ywu =  � �xyx o   � ��X�X 0 thetoken theTokeny m   � �zz �{{  \ \v l  � �|}~| r   � �� o   � ��W�W 0 thetoken theToken� n      ���  ;   � �� o   � ��V�V 0 resulttexts resultTexts} ( " found backslash-escaped character   ~ ��� D   f o u n d   b a c k s l a s h - e s c a p e d   c h a r a c t e r�Y  w l  � ����� k   � ��� ��� l  � ����� r   � ���� n   � ���� 4   � ��U�
�U 
cobj� l  � ���T�S� c   � ���� n  � ���� 4  � ��R�
�R 
cha � m   � ��Q�Q��� o   � ��P�P 0 thetoken theToken� m   � ��O
�O 
long�T  �S  � o   � ��N�N 0 	thevalues 	theValues� o      �M�M 0 theitem theItem� 2 , this will raise error -1728 if out of range   � ��� X   t h i s   w i l l   r a i s e   e r r o r   - 1 7 2 8   i f   o u t   o f   r a n g e� ��L� Q   � ����� r   � ���� c   � ���� o   � ��K�K 0 theitem theItem� m   � ��J
�J 
ctxt� n      ���  ;   � �� o   � ��I�I 0 resulttexts resultTexts� R      �H�G�
�H .ascrerr ****      � ****�G  � �F��E
�F 
errn� d      �� m      �D�D��E  � l  � ����� r   � ���� I  � ��C�B�
�C .Txt:FLitnull��� ��� null�B  � �A��@
�A 
For_� o   � ��?�? 0 theitem theItem�@  � n      ���  ;   � �� o   � ��>�> 0 resulttexts resultTexts� � � TO DO: or just throw 'unsupported object type' error, requiring user to get value's literal representation before passing it to `format text`   � ���   T O   D O :   o r   j u s t   t h r o w   ' u n s u p p o r t e d   o b j e c t   t y p e '   e r r o r ,   r e q u i r i n g   u s e r   t o   g e t   v a l u e ' s   l i t e r a l   r e p r e s e n t a t i o n   b e f o r e   p a s s i n g   i t   t o   ` f o r m a t   t e x t `�L  �  	 found $n   � ���    f o u n d   $ nt ��=� r   � ���� [   � ���� l  � ���<�;� n  � ���� I   � ��:�9�8�: 0 location  �9  �8  � o   � ��7�7 0 
matchrange 
matchRange�<  �;  � l  � ���6�5� n  � ���� I   � ��4�3�2�4 
0 length  �3  �2  � o   � ��1�1 0 
matchrange 
matchRange�6  �5  � o      �0�0 0 
startindex 
startIndex�=  �� 0 i  @ m   M N�/�/  A l  N U��.�-� \   N U��� l  N S��,�+� n  N S��� I   O S�*�)�(�* 	0 count  �)  �(  � o   N O�'�'  0 asocmatcharray asocMatchArray�,  �+  � m   S T�&�& �.  �-  ��  > ��� r   � ���� c   � ���� l  � ���%�$� n  � ���� I   � ��#��"�# *0 substringfromindex_ substringFromIndex_� ��!� o   � �� �  0 
startindex 
startIndex�!  �"  � o   � ��� 0 
asocstring 
asocString�%  �$  � m   � ��
� 
ctxt� n      ���  ;   � �� o   � ��� 0 resulttexts resultTexts� ��� r   � ���� n  � ���� 1   � ��
� 
txdl� 1   � ��
� 
ascr� o      �� 0 oldtids oldTIDs� ��� r   ���� m   � ��� ���  � n     ��� 1   �
� 
txdl� 1   � �
� 
ascr� ��� r  ��� c  ��� o  �� 0 resulttexts resultTexts� m  
�
� 
ctxt� o      �� 0 
resulttext 
resultText� ��� r  ��� o  �� 0 oldtids oldTIDs� n     ��� 1  �
� 
txdl� 1  �
� 
ascr� ��� L  �� o  �� 0 
resulttext 
resultText�  : ��
� conscase� ��
� consdiac� ��
� conshyph� ��
� conspunc� ��

� conswhit�
  ; �	�
�	 consnume�  ��  � R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ��� 
� 
errt� o      ���� 
0 eto eTo�   � I  #3������� 
0 _error  � ��� m  $'�� ���  f o r m a t   t e x t� ��� o  '(���� 0 etext eText� ��� o  ()���� 0 enumber eNumber� � � o  )*���� 0 efrom eFrom  �� o  *-���� 
0 eto eTo��  ��  ��  �  l     ��������  ��  ��    l     ��������  ��  ��    l     ��������  ��  ��   	 l     ��
��  
 J D--------------------------------------------------------------------    � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -	  l     ����  �� locale support -- TO DO: what other functionality should be exposed to user? if there's much more, consider moving to its own Localization library; bear in mind that NSLocale instances and other Cocoa objects generally shouldn't be returned to user as ASOC objects cause problems for autosave, script persistence, etc; instead, use localeIdentifier strings and convert to/from NSLocale at point of use    �$   l o c a l e   s u p p o r t   - -   T O   D O :   w h a t   o t h e r   f u n c t i o n a l i t y   s h o u l d   b e   e x p o s e d   t o   u s e r ?   i f   t h e r e ' s   m u c h   m o r e ,   c o n s i d e r   m o v i n g   t o   i t s   o w n   L o c a l i z a t i o n   l i b r a r y ;   b e a r   i n   m i n d   t h a t   N S L o c a l e   i n s t a n c e s   a n d   o t h e r   C o c o a   o b j e c t s   g e n e r a l l y   s h o u l d n ' t   b e   r e t u r n e d   t o   u s e r   a s   A S O C   o b j e c t s   c a u s e   p r o b l e m s   f o r   a u t o s a v e ,   s c r i p t   p e r s i s t e n c e ,   e t c ;   i n s t e a d ,   u s e   l o c a l e I d e n t i f i e r   s t r i n g s   a n d   c o n v e r t   t o / f r o m   N S L o c a l e   a t   p o i n t   o f   u s e  l     ��������  ��  ��    i  � � I     ������
�� .Txt:LLocnull��� ��� null��  ��   l     L      c      l    ���� n      I    ��!���� 60 sortedarrayusingselector_ sortedArrayUsingSelector_! "��" m    ## �$$  c o m p a r e :��  ��    n    %&% I    �������� 80 availablelocaleidentifiers availableLocaleIdentifiers��  ��  & n    '(' o    ���� 0 nslocale NSLocale( m     ��
�� misccura��  ��   m    ��
�� 
list , &> {"af", "af_NA", "af_ZA", "agq", ...}    �)) L >   { " a f " ,   " a f _ N A " ,   " a f _ Z A " ,   " a g q " ,   . . . } *+* l     ��������  ��  ��  + ,-, i  � �./. I     ������
�� .Txt:CLocnull��� ��� null��  ��  / L     00 c     121 l    3����3 n    454 I    �������� $0 localeidentifier localeIdentifier��  ��  5 n    676 I    �������� 0 currentlocale currentLocale��  ��  7 n    898 o    ���� 0 nslocale NSLocale9 m     ��
�� misccura��  ��  2 m    ��
�� 
ctxt- :;: l     ��������  ��  ��  ; <��< l     ��������  ��  ��  ��       %��=> ������?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\��  = #����������������������������������������������������������������������
�� 
pimr�� 60 _textsupportagentbundleid _TextSupportAgentBundleID�� (0 _unmatchedtexttype _UnmatchedTextType�� $0 _matchedtexttype _MatchedTextType�� &0 _matchedgrouptype _MatchedGroupType�� 0 _support  �� 
0 _error  �� $0 _matchinforecord _matchInfoRecord�� 0 _matchrecords _matchRecords�� &0 _matchedgrouplist _matchedGroupList�� 0 _findpattern _findPattern�� "0 _replacepattern _replacePattern�� 0 	_findtext 	_findText�� 0 _replacetext _replaceText
�� .Txt:Srchnull���     ctxt
�� .Txt:EPatnull���     ctxt
�� .Txt:ETemnull���     ctxt
�� .Txt:UppTnull���     ctxt
�� .Txt:CapTnull���     ctxt
�� .Txt:LowTnull���     ctxt
�� .Txt:PadTnull���     ctxt
�� .Txt:SliTnull���     ctxt
�� .Txt:TrmTnull���     ctxt�� 0 
_splittext 
_splitText�� 0 _splitpattern _splitPattern�� 0 	_jointext 	_joinText
�� .Txt:SplTnull���     ctxt
�� .Txt:JoiTnull���     ****
�� .Txt:SplPnull���     ctxt
�� .Txt:JoiPnull���     ****�� (0 _makevalueiterator _makeValueIterator
�� .Txt:FLitnull��� ��� null
�� .Txt:FTxtnull���     ctxt
�� .Txt:LLocnull��� ��� null
�� .Txt:CLocnull��� ��� null> ��]�� ]  ^^ ��_��
�� 
cobj_ ``   �� 
�� 
frmk��  
�� 
TxtU
�� 
TxtM
�� 
TxtG? aa   �� L
�� 
scpt@ �� V����bc���� 
0 _error  �� ��d�� d  ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo��  b ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eToc  f������ �� &0 throwcommanderror throwCommandError�� b  ࠡ����+ A �� �����ef���� $0 _matchinforecord _matchInfoRecord�� ��g�� g  ������~�� 0 
asocstring 
asocString��  0 asocmatchrange asocMatchRange� 0 
textoffset 
textOffset�~ 0 
recordtype 
recordType��  e �}�|�{�z�y�x�} 0 
asocstring 
asocString�|  0 asocmatchrange asocMatchRange�{ 0 
textoffset 
textOffset�z 0 
recordtype 
recordType�y 0 	foundtext 	foundText�x  0 nexttextoffset nextTextOffsetf �w�v�u�t�s�r�q�p�w *0 substringwithrange_ substringWithRange_
�v 
ctxt
�u 
leng
�t 
pcls�s 0 
startindex 
startIndex�r 0 endindex endIndex�q 0 	foundtext 	foundText�p �� $��k+  �&E�O���,E�O���k���lvB �o ��n�mhi�l�o 0 _matchrecords _matchRecords�n �kj�k j  �j�i�h�g�f�e�j 0 
asocstring 
asocString�i  0 asocmatchrange asocMatchRange�h  0 asocstartindex asocStartIndex�g 0 
textoffset 
textOffset�f (0 nonmatchrecordtype nonMatchRecordType�e "0 matchrecordtype matchRecordType�m  h �d�c�b�a�`�_�^�]�\�[�Z�d 0 
asocstring 
asocString�c  0 asocmatchrange asocMatchRange�b  0 asocstartindex asocStartIndex�a 0 
textoffset 
textOffset�` (0 nonmatchrecordtype nonMatchRecordType�_ "0 matchrecordtype matchRecordType�^  0 asocmatchstart asocMatchStart�] 0 asocmatchend asocMatchEnd�\ &0 asocnonmatchrange asocNonMatchRange�[ 0 nonmatchinfo nonMatchInfo�Z 0 	matchinfo 	matchInfoi �Y�X�W�V�U�Y 0 location  �X 
0 length  �W �V $0 _matchinforecord _matchInfoRecord
�U 
cobj�l W�j+  E�O��j+ E�O�ᦢ�E�O*�����+ E[�k/E�Z[�l/E�ZO*�����+ E[�k/E�Z[�l/E�ZO�����vC �T(�S�Rkl�Q�T &0 _matchedgrouplist _matchedGroupList�S �Pm�P m  �O�N�M�L�O 0 
asocstring 
asocString�N 0 	asocmatch 	asocMatch�M 0 
textoffset 
textOffset�L &0 includenonmatches includeNonMatches�R  k �K�J�I�H�G�F�E�D�C�B�A�@�?�K 0 
asocstring 
asocString�J 0 	asocmatch 	asocMatch�I 0 
textoffset 
textOffset�H &0 includenonmatches includeNonMatches�G "0 submatchresults subMatchResults�F 0 groupindexes groupIndexes�E (0 asocfullmatchrange asocFullMatchRange�D &0 asocnonmatchstart asocNonMatchStart�C $0 asocfullmatchend asocFullMatchEnd�B 0 i  �A 0 nonmatchinfo nonMatchInfo�@ 0 	matchinfo 	matchInfo�? &0 asocnonmatchrange asocNonMatchRangel 	�>�=�<�;�:�9�8�7�6�>  0 numberofranges numberOfRanges�= 0 rangeatindex_ rangeAtIndex_�< 0 location  �; 
0 length  �: �9 0 _matchrecords _matchRecords
�8 
cobj�7 �6 $0 _matchinforecord _matchInfoRecord�Q �jvE�O�j+  kE�O�j ��jk+ E�O�j+ E�O��j+ E�O Uk�kh 	*���k+ ��b  b  �+ E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO� 	��6FY hO��6F[OY��O� #�㨧�E�O*���b  �+ �k/�6FY hY hO�D �5��4�3no�2�5 0 _findpattern _findPattern�4 �1p�1 p  �0�/�.�-�0 0 thetext theText�/ 0 patterntext patternText�. &0 includenonmatches includeNonMatches�-  0 includematches includeMatches�3  n �,�+�*�)�(�'�&�%�$�#�"�!� ���, 0 thetext theText�+ 0 patterntext patternText�* &0 includenonmatches includeNonMatches�)  0 includematches includeMatches�( 0 asocpattern asocPattern�' 0 
asocstring 
asocString�& &0 asocnonmatchstart asocNonMatchStart�% 0 
textoffset 
textOffset�$ 0 
resultlist 
resultList�#  0 asocmatcharray asocMatchArray�" 0 i  �! 0 	asocmatch 	asocMatch�  0 nonmatchinfo nonMatchInfo� 0 	matchinfo 	matchInfo� 0 	foundtext 	foundTexto �����������������������
�	�� (0 asbooleanparameter asBooleanParameter� @0 asnsregularexpressionparameter asNSRegularExpressionParameter� ,0 asnormalizednsstring asNormalizedNSString� 
0 length  � @0 matchesinstring_options_range_ matchesInString_options_range_� 	0 count  �  0 objectatindex_ objectAtIndex_� 0 rangeatindex_ rangeAtIndex_� � 0 _matchrecords _matchRecords
� 
cobj� � 0 foundgroups foundGroups� 0 
startindex 
startIndex� &0 _matchedgrouplist _matchedGroupList� *0 substringfromindex_ substringFromIndex_
� 
ctxt
� 
pcls� 0 endindex endIndex
�
 
leng�	 0 	foundtext 	foundText� �2b  ��l+ E�Ob  ��l+ E�Ob  �j�m+ E�Ob  �k+ E�OjE�OkE�OjvE�O��jj�j+ lvm+ E�O }j�j+ kkh 
��k+ 	E�O*��jk+ 
��b  b  �+ E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO� 	��6FY hO� ��*���a ,��+ l%�6FY h[OY��O� 1��k+ a &E�Oa b  a �a �a ,a �a �6FY hO�E ����qr�� "0 _replacepattern _replacePattern� �s� s  ��� � 0 thetext theText� 0 patterntext patternText�  0 templatetext templateText�  q ������������ 0 thetext theText�� 0 patterntext patternText�� 0 templatetext templateText�� 0 
asocstring 
asocString�� 0 asocpattern asocPatternr ������������� ,0 asnormalizednsstring asNormalizedNSString�� @0 asnsregularexpressionparameter asNSRegularExpressionParameter�� 
0 length  �� �� |0 <stringbyreplacingmatchesinstring_options_range_withtemplate_ <stringByReplacingMatchesInString_options_range_withTemplate_� .b  �k+  E�Ob  �j�m+ E�O��jj�j+ lv��+ F �������tu���� 0 	_findtext 	_findText�� ��v�� v  ���������� 0 thetext theText�� 0 fortext forText�� &0 includenonmatches includeNonMatches��  0 includematches includeMatches��  t 
���������������������� 0 thetext theText�� 0 fortext forText�� &0 includenonmatches includeNonMatches��  0 includematches includeMatches�� 0 
resultlist 
resultList�� 0 oldtids oldTIDs�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 	foundtext 	foundText�� 0 i  u ������������������>�����������������
�� 
errn���Y
�� 
erob�� 
�� 
ascr
�� 
txdl
�� 
citm
�� 
leng
�� 
ctxt
�� 
pcls�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 	foundtext 	foundText�� 
�� .corecnte****       ****�� 0 foundgroups foundGroups�� 
��)��  )�����Y hOjvE�O��,E�O���,FOkE�O��k/�,E�O�� �[�\[Z�\Z�2E�Y �E�O� �b  ����a �6FY hO �l��-j kh 	�kE�O��,�[�\[�/\�i/2�,E�O�� �[�\[Z�\Z�2E�Y a E�O� �b  ����a jva �6FY hO�kE�O���/�,kE�O�� �[�\[Z�\Z�2E�Y a E�O� �b  ����a �6FY h[OY�WO���,FO�G �������wx���� 0 _replacetext _replaceText�� ��y�� y  �������� 0 thetext theText�� 0 fortext forText�� 0 newtext newText��  w �������������� 0 thetext theText�� 0 fortext forText�� 0 newtext newText�� 0 oldtids oldTIDs�� 0 	textitems 	textItems�� 0 
resulttext 
resultTextx ��������
�� 
ascr
�� 
txdl
�� 
citm
�� 
ctxt�� '��,E�O���,FO��-E�O���,FO��&E�O���,FO�H ��%����z{��
�� .Txt:Srchnull���     ctxt�� 0 thetext theText�� ����|
�� 
For_�� 0 fortext forText| ��}~
�� 
Usin} {�������� 0 matchformat matchFormat��  
�� SerECmpI~ ���
�� 
Repl {�������� 0 newtext newText��  
�� 
msng� �����
�� 
Retu� {�������� 0 resultformat resultFormat��  
�� RetEMatT��  z ������������������������ 0 thetext theText�� 0 fortext forText�� 0 matchformat matchFormat�� 0 newtext newText�� 0 resultformat resultFormat�� &0 includenonmatches includeNonMatches��  0 includematches includeMatches�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo{ #G��V����������c�������������������������������V��c���� "0 astextparameter asTextParameter
�� 
leng
�� 
errn���Y
�� 
erob�� 
�� 
msng
�� RetEMatT
�� 
cobj
�� RetEUmaT
�� RetEAllT�� >0 throwinvalidparameterconstant throwInvalidParameterConstant
�� SerECmpI�� 0 	_findtext 	_findText
�� SerECmpP�� 0 _findpattern _findPattern
�� SerECmpC
�� SerECmpD� 0 _replacetext _replaceText� "0 _replacepattern _replacePattern� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  � � 
0 _error  ����b  ��l+ E�Ob  ��l+ E�O��,j  )�����Y hO��  ؤ�  felvE[�k/E�Z[�l/E�ZY E��  eflvE[�k/E�Z[�l/E�ZY )��  eelvE[�k/E�Z[�l/E�ZY b  ��l+ O�a   a a  *�����+ VY V�a   *�����+ Y A�a   a g *�����+ VY $�a   *�����+ Y b  �a l+ Y �b  �a l+ E�O�a   a a  *���m+ VY S�a   *���m+ Y ?�a   a g *���m+ VY #�a   *���m+ Y b  �a l+ W X  *a  ����a !+ "I �s�����
� .Txt:EPatnull���     ctxt� 0 thetext theText�  � ��~�}�|�{� 0 thetext theText�~ 0 etext eText�} 0 enumber eNumber�| 0 efrom eFrom�{ 
0 eto eTo� �z�y��x�w�v�u���t�s
�z misccura�y *0 nsregularexpression NSRegularExpression�x "0 astextparameter asTextParameter�w 40 escapedpatternforstring_ escapedPatternForString_
�v 
ctxt�u 0 etext eText� �r�q�
�r 
errn�q 0 enumber eNumber� �p�o�
�p 
erob�o 0 efrom eFrom� �n�m�l
�n 
errt�m 
0 eto eTo�l  �t �s 
0 _error  � + ��,b  ��l+ k+ �&W X  *衢���+ 
J �k��j�i���h
�k .Txt:ETemnull���     ctxt�j 0 thetext theText�i  � �g�f�e�d�c�g 0 thetext theText�f 0 etext eText�e 0 enumber eNumber�d 0 efrom eFrom�c 
0 eto eTo� �b�a��`�_�^�]���\�[
�b misccura�a *0 nsregularexpression NSRegularExpression�` "0 astextparameter asTextParameter�_ 60 escapedtemplateforstring_ escapedTemplateForString_
�^ 
ctxt�] 0 etext eText� �Z�Y�
�Z 
errn�Y 0 enumber eNumber� �X�W�
�X 
erob�W 0 efrom eFrom� �V�U�T
�V 
errt�U 
0 eto eTo�T  �\ �[ 
0 _error  �h + ��,b  ��l+ k+ �&W X  *衢���+ 
K �S��R�Q���P
�S .Txt:UppTnull���     ctxt�R 0 thetext theText�Q �O��N
�O 
Loca� {�M�L�K�M 0 
localecode 
localeCode�L  
�K 
msng�N  � �J�I�H�G�F�E�D�J 0 thetext theText�I 0 
localecode 
localeCode�H 0 
asocstring 
asocString�G 0 etext eText�F 0 enumber eNumber�E 0 efrom eFrom�D 
0 eto eTo� ��C�B�A�@�?�>�=�<�%�;�:�C "0 astextparameter asTextParameter�B 0 
asnsstring 
asNSString
�A 
msng�@ "0 uppercasestring uppercaseString
�? 
ctxt�> *0 asnslocaleparameter asNSLocaleParameter�= 80 uppercasestringwithlocale_ uppercaseStringWithLocale_�< 0 etext eText� �9�8�
�9 
errn�8 0 enumber eNumber� �7�6�
�7 
erob�6 0 efrom eFrom� �5�4�3
�5 
errt�4 
0 eto eTo�3  �; �: 
0 _error  �P Q @b  b  ��l+ k+ E�O��  �j+ �&Y �b  ��l+ k+ �&W X 	 
*룤���+ L �25�1�0���/
�2 .Txt:CapTnull���     ctxt�1 0 thetext theText�0 �.��-
�. 
Loca� {�,�+�*�, 0 
localecode 
localeCode�+  
�* 
msng�-  � �)�(�'�&�%�$�#�) 0 thetext theText�( 0 
localecode 
localeCode�' 0 
asocstring 
asocString�& 0 etext eText�% 0 enumber eNumber�$ 0 efrom eFrom�# 
0 eto eTo� N�"�!� ��k����w���" "0 astextparameter asTextParameter�! 0 
asnsstring 
asNSString
�  
msng� &0 capitalizedstring capitalizedString
� 
ctxt� *0 asnslocaleparameter asNSLocaleParameter� <0 capitalizedstringwithlocale_ capitalizedStringWithLocale_� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �/ Q @b  b  ��l+ k+ E�O��  �j+ �&Y �b  ��l+ k+ �&W X 	 
*룤���+ M �������
� .Txt:LowTnull���     ctxt� 0 thetext theText� ���
� 
Loca� {��
�	� 0 
localecode 
localeCode�
  
�	 
msng�  � �������� 0 thetext theText� 0 
localecode 
localeCode� 0 
asocstring 
asocString� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� ��� �������������������� "0 astextparameter asTextParameter�  0 
asnsstring 
asNSString
�� 
msng�� "0 lowercasestring lowercaseString
�� 
ctxt�� *0 asnslocaleparameter asNSLocaleParameter�� 80 lowercasestringwithlocale_ lowercaseStringWithLocale_�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  � Q @b  b  ��l+ k+ E�O��  �j+ �&Y �b  ��l+ k+ �&W X 	 
*룤���+ N �����������
�� .Txt:PadTnull���     ctxt�� 0 thetext theText�� �����
�� 
toPl�� 0 toplaces toPlaces� ����
�� 
Char� {������� 0 padchar padChar��  � �����
�� 
From� {�������� 0 whichend whichEnd��  
�� LeTrLCha��  � 
���������������������� 0 thetext theText�� 0 toplaces toPlaces�� 0 padchar padChar�� 0 whichend whichEnd�� 0 	charcount 	charCount�� 0 padtext padText�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� ���	����%��������1��������������������� "0 astextparameter asTextParameter�� (0 asintegerparameter asIntegerParameter
�� 
leng
�� 
errn���Y
�� 
erob�� 
�� LeTrLCha
�� 
ctxt
�� LeTrTCha
�� LeTrBCha�� >0 throwinvalidparameterconstant throwInvalidParameterConstant�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� � �b  ��l+ E�Ob  ��l+ E�O���,E�O�j �Y hOb  ��l+ E�O��,j  )�����Y hO h��,���%E�[OY��O��  �[�\[Zk\Z�2�%Y a��  ��[�\[Zk\Z�2%Y J��  9�k  ��[�\[Zk\Z�2%Y �[�\[Zk\Z�l"2�%�%[�\[Zk\Z�2EY b  ��l+ W X  *a ����a + O ����������
�� .Txt:SliTnull���     ctxt�� 0 thetext theText�� ���
� 
FIdx� {���� 0 
startindex 
startIndex�  
� 
msng� ���
� 
TIdx� {���� 0 endindex endIndex�  
� 
msng�  � ��������� 0 thetext theText� 0 
startindex 
startIndex� 0 endindex endIndex� 0 	thelength 	theLength� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� ��������������!+=�{������ "0 astextparameter asTextParameter
� 
leng
� 
msng� (0 asintegerparameter asIntegerParameter
� 
errn��Y
� 
erob� 
� 
ctxt��[
� 
bool� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  � � 
0 _error  ��rb  ��l+ E�O��,E�O�� Tb  ��l+ E�O�j  )�����Y hO��  )��' �Y �� �Y �[�\[Z�\Zi2EY hY ��  )��l�Y hO�� Xb  ��l+ E�O�j  )����a Y hO��  +��' 	a Y �� �Y �[�\[Zk\Z�2EY hY hO�j �k�E�Y hO�j �k�E�Y hO�k	 	�ka &
 ��	 	��a &a & 	a Y hO�k kE�Y �� �E�Y hO�k kE�Y �� �E�Y hO�[�\[Z�\Z�2EW X  *a ����a + P �������
� .Txt:TrmTnull���     ctxt� 0 thetext theText� ���
� 
From� {���� 0 whichend whichEnd�  
� LeTrBCha�  � ��������� 0 thetext theText� 0 whichend whichEnd� 0 
startindex 
startIndex� 0 endindex endIndex� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� �������������	"	;���	Q�~�}� "0 astextparameter asTextParameter
� LeTrLCha
� LeTrTCha
� LeTrBCha� >0 throwinvalidparameterconstant throwInvalidParameterConstant
� 
cobj
� 
cha 
� 
ctxt� 0 etext eText� �|�{�
�| 
errn�{ 0 enumber eNumber� �z�y�
�z 
erob�y 0 efrom eFrom� �x�w�v
�x 
errt�w 
0 eto eTo�v  �~ �} 
0 _error  � � �b  ��l+ E�O���mv�kv b  ��l+ Y hO�� {��  �Y hOkilvE[�k/E�Z[�l/E�ZO��lv�kv  h��/� �kE�[OY��Y hO��lv�kv  h��/� �kE�[OY��Y hO�[�\[Z�\Z�2EVW X  *a ����a + Q �u	m�t�s���r�u 0 
_splittext 
_splitText�t �q��q �  �p�o�p 0 thetext theText�o 0 theseparator theSeparator�s  � �n�m�l�k�j�i�n 0 thetext theText�m 0 theseparator theSeparator�l 0 delimiterlist delimiterList�k 0 aref aRef�j 0 oldtids oldTIDs�i 0 
resultlist 
resultList� �h�g�f�e�d�c�b�	�	��a�`�_�^�]�h "0 aslistparameter asListParameter
�g 
kocl
�f 
cobj
�e .corecnte****       ****
�d 
pcnt
�c 
ctxt�b  � �\�[�Z
�\ 
errn�[�\�Z  �a �` 60 throwinvalidparametertype throwInvalidParameterType
�_ 
ascr
�^ 
txdl
�] 
citm�r _b  �k+  E�O 5�[��l kh  ��,�&��,FW X  b  �����+ [OY��O��,E�O���,FO��-E�O���,FO�R �Y	��X�W���V�Y 0 _splitpattern _splitPattern�X �U��U �  �T�S�T 0 thetext theText�S 0 patterntext patternText�W  � 
�R�Q�P�O�N�M�L�K�J�I�R 0 thetext theText�Q 0 patterntext patternText�P 0 asocpattern asocPattern�O 0 
asocstring 
asocString�N &0 asocnonmatchstart asocNonMatchStart�M 0 
resultlist 
resultList�L  0 asocmatcharray asocMatchArray�K 0 i  �J  0 asocmatchrange asocMatchRange�I  0 asocmatchstart asocMatchStart� 	��H�G�F�E�D�C�B�A�@�?�>�=�H @0 asnsregularexpressionparameter asNSRegularExpressionParameter�G ,0 asnormalizednsstring asNormalizedNSString�F 
0 length  �E @0 matchesinstring_options_range_ matchesInString_options_range_�D 	0 count  �C  0 objectatindex_ objectAtIndex_�B 0 rangeatindex_ rangeAtIndex_�A 0 location  �@ �? *0 substringwithrange_ substringWithRange_
�> 
ctxt�= *0 substringfromindex_ substringFromIndex_�V �b  �j�m+ E�Ob  �k+ E�OjE�OjvE�O��jj�j+ lvm+ E�O Fj�j+ kkh ��k+ jk+ E�O�j+ E�O��㩤�k+ 
�&�6FO��j+ E�[OY��O��k+ �&�6FO�S �<
\�;�:���9�< 0 	_jointext 	_joinText�; �8��8 �  �7�6�7 0 thelist theList�6 0 separatortext separatorText�:  � �5�4�3�2�1�5 0 thelist theList�4 0 separatortext separatorText�3 0 oldtids oldTIDs�2 0 delimiterlist delimiterList�1 0 
resulttext 
resultText� �0�/�.�-�,��+�*�)�(�'�&
�
�0 
ascr
�/ 
txdl�. "0 aslistparameter asListParameter
�- 
ctxt�,  � �%�$�#
�% 
errn�$�\�#  
�+ 
errn�*�Y
�) 
erob
�( 
errt
�' 
list�& �9 ?��,E�O���,FO b  �k+ �&E�W X  ���,FO)�������O���,FO�T �"
��!� ���
�" .Txt:SplTnull���     ctxt�! 0 thetext theText�  ���
� 
Sepa� {���� 0 theseparator theSeparator�  
� 
msng� ���
� 
Usin� {���� 0 matchformat matchFormat�  
� SerECmpI�  � �������� 0 thetext theText� 0 theseparator theSeparator� 0 matchformat matchFormat� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� 
���
���
�
��
�	�
�����%��� "0 astextparameter asTextParameter
� 
msng� 0 _splitpattern _splitPattern
� SerECmpI�
 0 
_splittext 
_splitText
�	 SerECmpP
� SerECmpC
� SerECmpD� >0 throwinvalidparameterconstant throwInvalidParameterConstant� 0 etext eText� ���
� 
errn� 0 enumber eNumber� � ���
�  
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  � � 
0 _error  � � b  ��l+ E�O��  *��l+ Y ]��  �� *��l+ VY F��  *��l+ Y 5��  �g *��l+ VY ��  *��l+ Y b  ��l+ W X  *a ����a + U ��5��������
�� .Txt:JoiTnull���     ****�� 0 thelist theList�� �����
�� 
Sepa� {����;�� 0 separatortext separatorText��  ��  � �������������� 0 thelist theList�� 0 separatortext separatorText�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� K�������W������ "0 astextparameter asTextParameter�� 0 	_jointext 	_joinText�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� ( *�b  ��l+ l+ W X  *墣���+ V ��g��������
�� .Txt:SplPnull���     ctxt�� 0 thetext theText��  � ������������ 0 thetext theText�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� u�������������� "0 astextparameter asTextParameter
�� 
cpar�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� % b  ��l+ �-EW X  *塢���+ W �����������
�� .Txt:JoiPnull���     ****�� 0 thelist theList�� �����
�� 
LiBr� {�������� 0 linebreaktype lineBreakType��  
�� LiBrLiOX��  � ������������� 0 thelist theList�� 0 linebreaktype lineBreakType�� 0 separatortext separatorText�� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� �������������
� LiBrLiOX
� 
lnfd
� LiBrLiCM
� 
ret 
� LiBrLiWi� >0 throwinvalidparameterconstant throwInvalidParameterConstant� 0 	_jointext 	_joinText� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �� P ?��  �E�Y '��  �E�Y ��  
��%E�Y b  ��l+ O*��l+ W X  	*꣤���+ X �������� (0 _makevalueiterator _makeValueIterator� ��� �  �� 0 
objectlist 
objectList�  � ��� 0 
objectlist 
objectList� 0 scpt  � ���� 0 scpt  � �������
� .ascrinit****      � ****� k     �� ��� ��� ���  �  �  � ���� 0 _objects  � 0 i  
� .aevtoappnull  �   � ****� ����
� 
list� 0 _objects  � 0 i  � �������
� .aevtoappnull  �   � ****�  �  �  � ����
� 
leng
� 
errn��
� 
cobj� 8b  kEc  Ob  b   �, )��lhY hOb   �b  /E� b   �&�Oj�OL � ��K S�Y �#�����
� .Txt:FLitnull��� ��� null�  � ���
� 
For_� 0 thevalue theValue�  � �����������~� 0 thevalue theValue� 0 oldtids oldTIDs� 0 	textitems 	textItems�  0 asocdescriptor asocDescriptor� 0 hextext hexText� "0 descriptiontext descriptionText� 0 scpt  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom�~ 
0 eto eTo� @./�}�|�{�z�y�x�wp�vu�u�tx�s�r�q�p��o������n�m�l�k�j�i�h�g�f�e�d5=?��c�b������a�`�_�^�]�\�[�Z�Y��X���W�V
�} 
kocl
�| 
obj 
�{ .corecnte****       ****
�z 
capp
�y 
bool
�x 
reco
�w 
scpt
�v 
pnam�u  �t  
�s 
pcls
�r 
ctxt
�q 
ascr
�p 
txdl
�o 
citm
�n 
optr
�m misccura�l 0 nsarray NSArray�k $0 arraywithobject_ arrayWithObject_�j  0 objectatindex_ objectAtIndex_�i 0 data  �h 0 description  �g "0 uppercasestring uppercaseString�f ,0 asnormalizednsstring asNormalizedNSString
�e 
spac�d��� �U�T�S
�U 
errn�T�\�S  
�c 
want
�b 
ocid
�a 
For_
�` 
seld
�_ .Txt:FLitnull��� ��� null�^ (0 _makevalueiterator _makeValueIterator
�] kfrmID  
�\ 
Scpt
�[ 
Deco�Z 
�Y .Txt:LitR****      � ****�X 0 etext eText� �R�Q�
�R 
errn�Q 0 enumber eNumber� �P�O�
�P 
erob�O 0 efrom eFrom� �N�M�L
�N 
errt�M 
0 eto eTo�L  �W �V 
0 _error  �`��\E�kv��l j 	 �kv��l j �&	 �kv��l j �&Z�kv��l j  ��,%�%W 	X  �Y1��,a   s_ a ,E�Oa _ a ,FO�a -E�Oa _ a ,FO�a &E�Oa _ a ,FO�a -E�Oa _ a ,FO�a &E�O�_ a ,FOa �%a %Y ���,a   � a a ,�k+ jk+ E�Ob  �j+ j+  j+ !k+ "a &E�O_ a ,E�O_ #_ a ,FO�a -E�Oa $_ a ,FO�a &[a \[Zl\Za %2E�O�_ a ,FW X  a &E�Oa '�%a (%Y  �a &W X  )hY hO�kv��l j	 ��&a *,a + �& b C�j+  a &E�O�a ,	 	�a -�& �[a \[Zl\Za %2E�Y hOa .�%a /%W X  a 0*a 1��&a 2,l 3%Y hO .*�kvk+ 4E�O*�b  a 50 *a 6�a 7fa 8 9UW X  a :W X ; <*a =����a >+ ?VZ �K��J�I���H
�K .Txt:FTxtnull���     ctxt�J 0 templatetext templateText�I �G�F�E
�G 
Usin�F 0 	thevalues 	theValues�E  � �D�C�B�A�@�?�>�=�<�;�:�9�8�7�6�5�4�D 0 templatetext templateText�C 0 	thevalues 	theValues�B 0 asocpattern asocPattern�A 0 
asocstring 
asocString�@  0 asocmatcharray asocMatchArray�? 0 resulttexts resultTexts�> 0 
startindex 
startIndex�= 0 i  �< 0 
matchrange 
matchRange�; 0 thetoken theToken�: 0 theitem theItem�9 0 oldtids oldTIDs�8 0 
resulttext 
resultText�7 0 etext eText�6 0 enumber eNumber�5 0 efrom eFrom�4 
0 eto eTo� #�3�2�1�0�/�.�-�,:;�+�*�)�(�'�&�%z�$�#�"�!�� �����������3 "0 aslistparameter asListParameter
�2 misccura�1 *0 nsregularexpression NSRegularExpression
�0 
msng�/ Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_�. 0 
asnsstring 
asNSString�- 
0 length  �, @0 matchesinstring_options_range_ matchesInString_options_range_�+ 	0 count  �*  0 objectatindex_ objectAtIndex_�) 0 rangeatindex_ rangeAtIndex_�( 0 location  �' �& *0 substringwithrange_ substringWithRange_
�% 
ctxt
�$ 
cobj
�# 
cha 
�" 
long�!  � ���
� 
errn��\�  
�  
For_
� .Txt:FLitnull��� ��� null� *0 substringfromindex_ substringFromIndex_
� 
ascr
� 
txdl� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �H4b  �k+  E�O��,�j�m+ E�Ob  �k+ E�O��jj�j+ lvm+ E�OjvE�OjE�O�� � �j�j+ kkh ��k+ jk+ E�O���j+ ��k+ a &�6FO��k+ a &E�O�a   	��6FY 3�a �a i/a &/E�O �a &�6FW X  *a �l �6FO�j+ �j+ E�[OY�xO��k+ a &�6FO_ a ,E�Oa _ a ,FO�a &E�O�_ a ,FO�VW X  *a  ���] a !+ "[ ������
� .Txt:LLocnull��� ��� null�  �  �  � �
�	�#��
�
 misccura�	 0 nslocale NSLocale� 80 availablelocaleidentifiers availableLocaleIdentifiers� 60 sortedarrayusingselector_ sortedArrayUsingSelector_
� 
list� ��,j+ �k+ �&\ �/�����
� .Txt:CLocnull��� ��� null�  �  �  � �� ������
� misccura�  0 nslocale NSLocale�� 0 currentlocale currentLocale�� $0 localeidentifier localeIdentifier
�� 
ctxt� ��,j+ j+ �&ascr  ��ޭ