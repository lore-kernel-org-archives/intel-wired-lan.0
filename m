From: Julia Lawall <julia.lawall@inria.fr>
Date: Mon, 18 Apr 2022 09:13:22 +0200 (CEST)
Subject: [Intel-wired-lan] [PATCH v4] intel: igb: igb_ethtool.c: Convert
 kmap() to kmap_local_page()
In-Reply-To: <20220418061430.6605-1-eng.alaamohamedsoliman.am@gmail.com>
References: <20220418061430.6605-1-eng.alaamohamedsoliman.am@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204180911430.2860@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On Mon, 18 Apr 2022, Alaa Mohamed wrote:

> The use of kmap() is being deprecated in favor of kmap_local_page()
> where it is feasible.
>
> With kmap_local_page(), the mapping is per thread, CPU local and not
> globally visible. Therefore igb_check_lbtest_frame() is a function
> where the use of kmap_local_page() in place of kmap() is correctly
> suited.

Same comment as the previous one.  What is it about igb_check_lbtest_frame
that makes this the right choice?

The subject line also does not look correct.  Normally, one does not put
an extension on a file name in a subject line, ie igb_ethtool.c.  Have you
used git log --oneline to see what subject line others have used for this
driver?

julia

>
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
> changes in V2:
> 	fix kunmap_local path value to take address of the mapped page.
> ---
> changes in V3:
> 	edit commit message to be clearer
> ---
> changes in V4:
> 	edit the commit message
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 2a5782063f4c..c14fc871dd41 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -1798,14 +1798,14 @@ static int igb_check_lbtest_frame(struct igb_rx_buffer *rx_buffer,
>
>  	frame_size >>= 1;
>
> -	data = kmap(rx_buffer->page);
> +	data = kmap_local_page(rx_buffer->page);
>
>  	if (data[3] != 0xFF ||
>  	    data[frame_size + 10] != 0xBE ||
>  	    data[frame_size + 12] != 0xAF)
>  		match = false;
>
> -	kunmap(rx_buffer->page);
> +	kunmap_local(data);
>
>  	return match;
>  }
> --
> 2.35.2
>
>
>
