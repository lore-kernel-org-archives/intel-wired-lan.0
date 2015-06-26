From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 25 Jun 2015 19:32:41 -0700
Subject: [Intel-wired-lan] [PATCH net-next] fm10k: create "correct"
 header for the remote end on connect
In-Reply-To: <1435270324-29738-1-git-send-email-jacob.e.keller@intel.com>
References: <1435270324-29738-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1435285961.16800.57.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-06-25 at 15:12 -0700, Jacob Keller wrote:
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
> @@ -899,6 +899,48 @@ static void
> fm10k_mbx_create_disconnect_hdr(struct fm10k_mbx_info *mbx)
>  }
>  
>  /**
> + *  fm10k_mbx_create_fake_disconnect_hdr - Generate a false
> disconnect mailbox header
> + *  @mbx: pointer to mailbox
> + *
> + *  This function creates a fake disconnect header for loading into
> remote
> + *  mailbox header. The primary purpose is to prevent errors on
> immediate
> + *  start up after mbx->connect.
> + **/
> +static void fm10k_mbx_create_fake_disconnect_hdr(struct
> fm10k_mbx_info *mbx)
> +{
> +       u32 hdr = FM10K_MSG_HDR_FIELD_SET(FM10K_MSG_DISCONNECT, TYPE)
> |
> +                 FM10K_MSG_HDR_FIELD_SET(mbx->head, TAIL) |
> +                 FM10K_MSG_HDR_FIELD_SET(mbx->tail, HEAD);
> +       u16 crc = fm10k_crc_16b(&hdr, mbx->local, 1);
> +
> +       mbx->mbx_lock |= FM10K_MBX_ACK;
> +
> +       /* load header to memory to be written */
> +       mbx->mbx_hdr = hdr | FM10K_MSG_HDR_FIELD_SET(crc, CRC);
> +}
> +
> +/**
> + *  fm10k_mbx_create_fake_disconnect_hdr - Generate a false
> disconnect mailbox header
> + *  @mbx: pointer to mailbox
> + *
> + *  This function creates a fake disconnect header for loading into
> remote
> + *  mailbox header. The primary purpose is to prevent errors on
> immediate
> + *  start up after mbx->connect.
> + **/
> +static void fm10k_mbx_create_fake_disconnect_hdr(struct
> fm10k_mbx_info *mbx)
> +{
> +       u32 hdr = FM10K_MSG_HDR_FIELD_SET(FM10K_MSG_DISCONNECT, TYPE)
> |
> +                 FM10K_MSG_HDR_FIELD_SET(mbx->head, TAIL) |
> +                 FM10K_MSG_HDR_FIELD_SET(mbx->tail, HEAD);
> +       u16 crc = fm10k_crc_16b(&hdr, mbx->local, 1);
> +
> +       mbx->mbx_lock |= FM10K_MBX_ACK;
> +
> +       /* load header to memory to be written */
> +       mbx->mbx_hdr = hdr | FM10K_MSG_HDR_FIELD_SET(crc, CRC);
> +}

Was there a reason for having 2 duplicate functions back-2-back? :-)
Once I deleted the duplicate function, the driver compiles.

Please re-submit with the patch fixed up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150625/7241aa2d/attachment-0001.asc>
