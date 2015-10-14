From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 14 Oct 2015 08:15:33 -0700
Subject: [Intel-wired-lan] [next-queue 15/17] fm10k: change default Tx
 ITR to 25usec
In-Reply-To: <1444779554-20464-15-git-send-email-jacob.e.keller@intel.com>
References: <1444779554-20464-1-git-send-email-jacob.e.keller@intel.com>
 <1444779554-20464-15-git-send-email-jacob.e.keller@intel.com>
Message-ID: <561E7195.2010605@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/13/2015 04:39 PM, Jacob Keller wrote:
> The current default ITR for Tx is overly restrictive. Using a simple
> netperf TCP_STREAM test, we top out at about 10Gb/s for a single thread
> when running using 1500 byte frames. By reducing the ITR value to 25usec
> (up to 40K interrupts a second from 10K), we are able to achieve 36Gb/s
> for a single thread TCP stream test.
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/fm10k/fm10k.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
> index bf2cc6f78418..5eb42fd21d3f 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k.h
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
> @@ -171,11 +171,12 @@ struct fm10k_ring_container {
>   #define FM10K_ITR_MAX		0x0FFF	/* maximum value for ITR */
>   #define FM10K_ITR_10K		100	/* 100us */
>   #define FM10K_ITR_20K		50	/* 50us */
> +#define FM10K_ITR_40K		25	/* 25us */
>   #define FM10K_ITR_ADAPTIVE	0x8000	/* adaptive interrupt moderation flag */
>   
>   #define ITR_IS_ADAPTIVE(itr) (!!(itr & FM10K_ITR_ADAPTIVE))
>   
> -#define FM10K_TX_ITR_DEFAULT	FM10K_ITR_10K
> +#define FM10K_TX_ITR_DEFAULT	FM10K_ITR_40K
>   #define FM10K_RX_ITR_DEFAULT	FM10K_ITR_20K
>   #define FM10K_ITR_ENABLE	(FM10K_ITR_AUTOMASK | FM10K_ITR_MASK_CLEAR)

Even 40K might be a bit restrictive.  I've found that 10Gb NICs need 
about 12K interrupts per second to avoid depleting the socket buffers in 
the case of a UDP test.  You might want to see if you see performance 
gains by taking it up to 50K maybe even 60K.  As far as test cases to 
use for tuning it would be useful to use a UDP_STREAM test instead of 
TCP_STREAM since UDP is not bound by the link partner throughput.

- Alex
