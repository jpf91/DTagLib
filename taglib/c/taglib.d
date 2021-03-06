/* Partially converted to D from tag_c.h by htod */
module taglib.c.taglib;

extern (C):

struct _N1
{
    int dummy;
}

alias _N1 TagLib_File;
struct _N2
{
    int dummy;
}
alias _N2 TagLib_Tag;
struct _N3
{
    int dummy;
}
alias _N3 TagLib_AudioProperties;

/*!
 * By default all strings coming into or out of TagLib's C API are in UTF8.
 * However, it may be desirable for TagLib to operate on Latin1 (ISO-8859-1)
 * strings in which case this should be set to FALSE.
 */
void  taglib_set_strings_unicode(int unicode);

/*!
 * TagLib can keep track of strings that are created when outputting tag values
 * and clear them using taglib_tag_clear_strings().  This is enabled by default.
 * However if you wish to do more fine grained management of strings, you can do
 * so by setting \a management to FALSE.
 */
void  taglib_set_string_management_enabled(int management);

/*!
 * Explicitly free a string returned from TagLib
 */
version(Windows)
{
    void taglib_free(void* pointer);
}
else
{
    import core.stdc.stdlib;
    alias free taglib_free;
}

/*******************************************************************************
 * File API
 ******************************************************************************/

enum TagLib_File_Type
{
    TagLib_File_MPEG,
    TagLib_File_OggVorbis,
    TagLib_File_FLAC,
    TagLib_File_MPC,
    TagLib_File_OggFlac,
    TagLib_File_WavPack,
    TagLib_File_Speex,
    TagLib_File_TrueAudio,
    TagLib_File_MP4,
    TagLib_File_ASF,
}

/*!
 * Creates a TagLib file based on \a filename.  TagLib will try to guess the file
 * type.
 * 
 * \returns NULL if the file type cannot be determined or the file cannot
 * be opened.
 */
TagLib_File * taglib_file_new(const char*filename);

/*!
 * Creates a TagLib file based on \a filename.  Rather than attempting to guess
 * the type, it will use the one specified by \a type.
 */
TagLib_File * taglib_file_new_type(const char*filename, TagLib_File_Type type);

/*!
 * Frees and closes the file.
 */
void  taglib_file_free(TagLib_File *file);

/*!
 * Returns true if the file is open and readable and valid information for
 * the Tag and / or AudioProperties was found.
 */

int  taglib_file_is_valid(TagLib_File *file);

/*!
 * Returns a pointer to the tag associated with this file.  This will be freed
 * automatically when the file is freed.
 */
TagLib_Tag * taglib_file_tag(TagLib_File *file);

/*!
 * Returns a pointer to the the audio properties associated with this file.  This
 * will be freed automatically when the file is freed.
 */
TagLib_AudioProperties * taglib_file_audioproperties(TagLib_File *file);

/*!
 * Saves the \a file to disk.
 */
int  taglib_file_save(TagLib_File *file);

/******************************************************************************
 * Tag API
 ******************************************************************************/

/*!
 * Returns a string with this tag's title.
 *
 * \note By default this string should be UTF8 encoded and its memory should be
 * freed using taglib_tag_free_strings().
 */
char * taglib_tag_title(TagLib_Tag *tag);

/*!
 * Returns a string with this tag's artist.
 *
 * \note By default this string should be UTF8 encoded and its memory should be
 * freed using taglib_tag_free_strings().
 */
char * taglib_tag_artist(TagLib_Tag *tag);

/*!
 * Returns a string with this tag's album name.
 *
 * \note By default this string should be UTF8 encoded and its memory should be
 * freed using taglib_tag_free_strings().
 */
char * taglib_tag_album(TagLib_Tag *tag);

/*!
 * Returns a string with this tag's comment.
 *
 * \note By default this string should be UTF8 encoded and its memory should be
 * freed using taglib_tag_free_strings().
 */
char * taglib_tag_comment(TagLib_Tag *tag);

/*!
 * Returns a string with this tag's genre.
 *
 * \note By default this string should be UTF8 encoded and its memory should be
 * freed using taglib_tag_free_strings().
 */
char * taglib_tag_genre(TagLib_Tag *tag);

/*!
 * Returns the tag's year or 0 if year is not set.
 */
uint  taglib_tag_year(TagLib_Tag *tag);

/*!
 * Returns the tag's track number or 0 if track number is not set.
 */
uint  taglib_tag_track(TagLib_Tag *tag);

/*!
 * Sets the tag's title.
 *
 * \note By default this string should be UTF8 encoded.
 */
void  taglib_tag_set_title(TagLib_Tag *tag, const char *title);

/*!
 * Sets the tag's artist.
 *
 * \note By default this string should be UTF8 encoded.
 */
void  taglib_tag_set_artist(TagLib_Tag *tag, const char *artist);

/*!
 * Sets the tag's album.
 *
 * \note By default this string should be UTF8 encoded.
 */
void  taglib_tag_set_album(TagLib_Tag *tag, const char *album);

/*!
 * Sets the tag's comment.
 *
 * \note By default this string should be UTF8 encoded.
 */
void  taglib_tag_set_comment(TagLib_Tag *tag, const char *comment);

/*!
 * Sets the tag's genre.
 *
 * \note By default this string should be UTF8 encoded.
 */
void  taglib_tag_set_genre(TagLib_Tag *tag, const char *genre);

/*!
 * Sets the tag's year.  0 indicates that this field should be cleared.
 */
void  taglib_tag_set_year(TagLib_Tag *tag, uint year);

/*!
 * Sets the tag's track number.  0 indicates that this field should be cleared.
 */
void  taglib_tag_set_track(TagLib_Tag *tag, uint track);

/*!
 * Frees all of the strings that have been created by the tag.
 */
void  taglib_tag_free_strings();

/******************************************************************************
 * Audio Properties API
 ******************************************************************************/

/*!
 * Returns the length of the file in seconds.
 */
int  taglib_audioproperties_length(TagLib_AudioProperties *audioProperties);

/*!
 * Returns the bitrate of the file in kb/s.
 */
int  taglib_audioproperties_bitrate(TagLib_AudioProperties *audioProperties);

/*!
 * Returns the sample rate of the file in Hz.
 */
int  taglib_audioproperties_samplerate(TagLib_AudioProperties *audioProperties);

/*!
 * Returns the number of channels in the audio stream.
 */
int  taglib_audioproperties_channels(TagLib_AudioProperties *audioProperties);

/*******************************************************************************
 * Special convenience ID3v2 functions
 *******************************************************************************/

enum TagLib_ID3v2_Encoding
{
    TagLib_ID3v2_Latin1,
    TagLib_ID3v2_UTF16,
    TagLib_ID3v2_UTF16BE,
    TagLib_ID3v2_UTF8,
}

/*!
 * This sets the default encoding for ID3v2 frames that are written to tags.
 */

void  taglib_id3v2_set_default_text_encoding(TagLib_ID3v2_Encoding encoding);

