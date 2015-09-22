From: Mark Rustad <mrustad@gmail.com>
Date: Mon, 21 Sep 2015 22:03:42 -0700
Subject: [Intel-wired-lan] [PATCH] igb: add more checks for disconnected
 adapter
In-Reply-To: <5600D5A2.70403@redhat.com>
References: <1442855488-27453-1-git-send-email-jarod@redhat.com>
 <56007D34.1070306@gmail.com> <5600D5A2.70403@redhat.com>
Message-ID: <5600E12E.4040005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/21/15 9:14 PM, Jarod Wilson wrote:
> Just switching to adapter->io_addr everywhere seems to not work as 
> noted above. :\ Note that I'm also chasing this from the other end 
> with the author of the pci patches that seem to have triggered this, 
> so the real bug might be over in pci-land, but hardening against 
> explosions in igb still seems like a worthwhile effort here.

My understanding is that there can be problems if too many writes to a
removed device happen. That is why ixgbe avoids doing that by testing
for removal in some places. The io_addr does get used in the transmit
path simply to avoid adding a test to that hot path. That approach
seems to be working well for ixgbe.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 867 bytes
Desc: OpenPGP digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150921/cb90f123/attachment.asc>
