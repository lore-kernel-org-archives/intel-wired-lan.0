From: Pavel Machek <pavel@ucw.cz>
Date: Wed, 20 Dec 2017 17:01:35 +0100
Subject: [Intel-wired-lan] v4.15-rc2 on thinkpad x60: ethernet stopped
 working
In-Reply-To: <20171220155421.GA3849@amd>
References: <20171210083949.GA3872@amd>
 <d1ae924b-4d8f-a787-4c07-1f2db91482e5@gmail.com>
 <20171215092849.GB15090@amd>
 <20171215.105210.103516329605719086.davem@davemloft.net>
 <20171218102657.GB5338@amd>
 <5c0be4c4-5a56-cc7b-7b5a-345f446e788e@intel.com>
 <20171218115817.GA17054@amd>
 <077087f2-551a-c045-6b07-b1b661e53dad@intel.com>
 <9B4A1B1917080E46B64F07F2989DADD69845BBE2@ORSMSX110.amr.corp.intel.com>
 <20171220155421.GA3849@amd>
Message-ID: <20171220160135.GA3841@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed 2017-12-20 16:54:21, Pavel Machek wrote:
> Hi!
> 
> > >> Before ask for reverting 19110cfbb..., please, check if follow patch 
> > >> of Benjamin work for you http://patchwork.ozlabs.org/patch/846825/
> 
> > >
> > Pavel, before ask for revert - let's check Benjamin's patch following to his previous patch. Previous patch was not competed and latest one come to complete changes.
> >
> 
> v4.15-rc4+:
> 
> Ethernet works with 19110cfbb reverted.
> 
> Ethernet works With patchwork.ozlabs.org/patch/846825/ applied.

Hmm. So... ethernet originally did not work with patch/846825/ applied
or 19110cfbb reverted, so I re-plugged ethernet cables. Now it works
even with plain v4.15-rc4+.

So it looks like the bug was fixed in the mainline in the meantime...?

Sorry for the noise,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171220/4cd6c7ff/attachment.asc>
