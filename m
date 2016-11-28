From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 28 Nov 2016 14:26:02 -0800
Subject: [Intel-wired-lan] [net PATCH 0/2] Don't use lco_csum to compute
	IPv4 checksum
In-Reply-To: <20161128153927.15466.99193.stgit@ahduyck-blue-test.jf.intel.com>
References: <20161128153927.15466.99193.stgit@ahduyck-blue-test.jf.intel.com>
Message-ID: <1480371962.2402.36.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-11-28 at 10:42 -0500, Alexander Duyck wrote:
> When I implemented the GSO partial support in the Intel drivers I was
> using
> lco_csum to compute the checksum that we needed to plug into the IPv4
> checksum field in order to cancel out the data that was not a part of the
> IPv4 header.? However this didn't take into account that the transport
> offset might be pointing to the inner transport header.
> 
> Instead of using lco_csum I have just coded around it so that we can use
> the outer IP header plus the IP header length to determine where we need
> to
> start our checksum and then just call csum_partial ourselves.
> 
> This should fix the SIT issue reported on igb interfaces as well as
> simliar
> issues that would pop up on other Intel NICs.
> 
> ---
> 
> Alexander Duyck (2):
> ????? igb/igbvf: Don't use lco_csum to compute IPv4 checksum
> ????? ixgbe/ixgbevf: Don't use lco_csum to compute IPv4 checksum

Stephen, I have applied Alex's patches to my net-queue tree. ?Can you
confirm they resolve the bug seen?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161128/65505eaa/attachment.asc>
