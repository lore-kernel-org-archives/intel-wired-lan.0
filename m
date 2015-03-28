From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 27 Mar 2015 20:32:15 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix documentation
In-Reply-To: <1427250584-22752-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427250584-22752-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427513535.2497.82.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-03-24 at 19:29 -0700, Jeff Kirsher wrote:
> From: Stephen Hemminger <stephen@networkplumber.org>
> 
> The MTU values in the documentation do not match the source.
> The source has frame limit of IXGBE_MAX_JUMBO_FRAME_SIZE (9728)
> which is MTU of 9710 because of the accounting for Ethernet header
> and CRC.
> 
> Also, don't refer to the obsolete ifconfig command.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150327/6573344c/attachment.asc>
