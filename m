From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Wed, 11 Nov 2015 22:13:48 +0000
Subject: [Intel-wired-lan] regression in ixgbe SFP detection patch
In-Reply-To: <87618083B2453E4A8714035B62D67992504DF0AA@FMSMSX105.amr.corp.intel.com>
References: <20151111173527.GA3641@gandi.net>
 <87618083B2453E4A8714035B62D67992504DF0AA@FMSMSX105.amr.corp.intel.com>
Message-ID: <424516AF-C3E7-4D00-8889-ED7EA8EF315E@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

William,

Emil S <emil.s.tantilov@intel.com> wrote:

>> It also fixes my issue: even if eth{2,3} are still up with no carrier, I
>> don't have any kworker in D state.
> 
> It appears that you have 2 ports with empty cages. If that is the case there
> is no reason to keep the interfaces up. If you bring them down, or plug the SFP+
> modules the kworkers should stop.
> 
>> So, is it something we should consider as a regression, in that case I
>> can send a formal patch, or do you need some more information to help
>> you debug it?
> 
> If the diff above is the patch you are referring to then you will break the
> SFP+ detection in the case where the driver was loaded while there were no
> SFP+ modules present in the cages.

Just so you know, there are patches in queue that will improve this situation in two ways:

1) When the I2C probe times out, the code assumes that the cage is empty and does not retry the access until the next probe.

2) The driver will use its own private workqueue, so it will not affect the system workqueues at all.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151111/e2ab4861/attachment.asc>
