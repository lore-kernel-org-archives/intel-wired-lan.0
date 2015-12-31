From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 30 Dec 2015 21:37:48 -0800
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: synchronize link_up and
 link_speed of a slave interface
In-Reply-To: <1451538295-15823-2-git-send-email-zyjzyj2000@gmail.com>
References: <7EED4F91-2DE5-407F-BA6A-681ED57650E4@intel.com>
 <1451538295-15823-1-git-send-email-zyjzyj2000@gmail.com>
 <1451538295-15823-2-git-send-email-zyjzyj2000@gmail.com>
Message-ID: <1451540268.3348.108.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-12-31 at 13:04 +0800, zyjzyj2000 at gmail.com wrote:
> From: Zhu Yanjun <yanjun.zhu@windriver.com>
> 
> According to the suggestions from Rustad, Mark D, to all the slave?
> interfaces, the link_speed and link_up should be synchronized since
> the time span between link_up and link_speed will make some virtual
> NICs not work well, such as a bonding driver in 802.3ad mode.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@windriver.com>
> ---

Since this is version 5 of your original patch, you should be putting
the change log of this patch here, so that we can follow how you got to
this point. ?This helpful for the reviewers (and me, the maintainer).
?For example:
v2: dropped the "else" case of "if" statement, based on feedback from
? ? Jeff Kirsher
v3: changed the if statement to simply return when the link speed is
? ? unknown on X540 parts based on feedback from Emil Tantilov
v4: updated code comment and if statement to test for IFF_SLAVE flag
V5: simplified code comment and if statement to only test for IFF_SLAVE
? ? flag and unknown link speed.

Of course, you can expand on what I have above, I just did a quick
summary of the changes as an example of a change log.?

> ?drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +++++
> ?1 file changed, 5 insertions(+)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151230/dd49f916/attachment-0001.asc>
