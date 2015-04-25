From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 24 Apr 2015 18:07:20 -0700
Subject: [Intel-wired-lan] [Patch net] igb: pass the correct maxlen for
	eth_get_headlen()
In-Reply-To: <1429724760-10075-1-git-send-email-xiyou.wangcong@gmail.com>
References: <1429724760-10075-1-git-send-email-xiyou.wangcong@gmail.com>
Message-ID: <1429924040.2644.63.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-04-22 at 10:45 -0700, Cong Wang wrote:
> The second parameter of eth_get_headlen() is the length of
> the frame buffer, not the header length of skb.
> 
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Dropping this patch based on feedback from Alex.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150424/fe67a989/attachment.asc>
