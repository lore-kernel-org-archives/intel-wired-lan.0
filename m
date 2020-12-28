From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 28 Dec 2020 10:33:59 -0800
Subject: [Intel-wired-lan] [PATCH net v1] virtchnl: Fix layout of RSS
 structures
In-Reply-To: <20201228103633.11621-1-mateusz.palczewski@intel.com>
References: <20201228103633.11621-1-mateusz.palczewski@intel.com>
Message-ID: <CAKgT0Uf-Exy1qhZYhKTe=mWf6i8L-FcaUYT0zGnyVWDq-pnfqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Dec 28, 2020 at 2:36 AM Mateusz Palczewski
<mateusz.palczewski@intel.com> wrote:
>
> From: Norbert Ciosek <norbertx.ciosek@intel.com>
>
> Move "key" and "lut" fields at the end of RSS structures.
> They are arrays of size 1 used to fill in the data
> in dynamically allocated memory located after both structures.
> Previous layout could lead to unwanted compiler optimizations
> in loops when iterating over these arrays.
>
> Fixes: 65ece6de0114 ("virtchnl: Add missing explicit padding to structures")
> Signed-off-by: Norbert Ciosek <norbertx.ciosek@intel.com>
> ---
>  include/linux/avf/virtchnl.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
> index ac4a1d3..44945d6 100644
> --- a/include/linux/avf/virtchnl.h
> +++ b/include/linux/avf/virtchnl.h
> @@ -529,8 +529,8 @@ struct virtchnl_eth_stats {
>  struct virtchnl_rss_key {
>         u16 vsi_id;
>         u16 key_len;
> -       u8 key[1];         /* RSS hash key, packed bytes */
>         u8 pad[1];
> +       u8 key[1];         /* RSS hash key, packed bytes */
>  };
>
>  VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
> @@ -538,8 +538,8 @@ VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
>  struct virtchnl_rss_lut {
>         u16 vsi_id;
>         u16 lut_entries;
> -       u8 lut[1];        /* RSS lookup table */
>         u8 pad[1];
> +       u8 lut[1];        /* RSS lookup table */
>  };
>
>  VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);

This makes absolutely no sense. Isn't it going to break compatibility
with existing devices that already have the old definitions? If the
key and lut are meant to be dynamically allocated it doesn't make
sense to have it size 1. Defining them with a length of 1 is incorrect
for how these are handled in the kernel. It just looks wrong as my
first instinct was to ask about why you would define an array of size
1? You should be defining the key and lut without size, so "key[]" and
"lut[]". That is how we define dynamically allocated fields at the end
of structure.

If the lut and key are supposed to be dynamically allocated you
shouldn't have the pad at all. You should remove it from the
structures in question.
