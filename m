From: Gavin Lambert <gavin.lambert@compacsort.com>
Date: Thu, 19 Oct 2017 00:23:49 +0000
Subject: [Intel-wired-lan] Packet loss on 82571EB with kernel 4.9
In-Reply-To: <1508345023.13406.6.camel@intel.com>
References: <SG2PR03MB187291B811B5438AEADC53AE844C0@SG2PR03MB1872.apcprd03.prod.outlook.com>
 <1508345023.13406.6.camel@intel.com>
Message-ID: <SG2PR03MB187249CC7E902081B5863FC984420@SG2PR03MB1872.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 19 October 2017 05:44, quoth Jeff Kirsher:
> On Tue, 2017-10-17 at 03:05 +0000, Gavin Lambert wrote:
> > (Please explicitly CC me in any replies.) I have a computer with an
> > Intel 82571EB 2-port card using the e1000e driver.  I've noticed that
> > it appears to be dropping some transmitted
> > packets:
[...]
> > What information is needed to diagnose this further and correct the
> > problem?
> 
> Any chance you can try the latest stable kernel 4.13.8 or even the latest
> kernel from Linus's tree (4.14-rc5)?  This will let us know if the issue still
> persists in the latest upstream kernel or if the issue has been fixed already.
> 
> Of course, if the issue is fixed in either of the two newer kernels, then you
> would just need to work with Debian about getting a driver update to thier
> 4.9 kernel release.
> 
> I have also added Sasha (e1000e maintainer) to this email thread so that he is
> aware of the issue and can provide additional assistance in troubleshooting
> the issue.

I should be able to try that a little later.  Although it's possibly also worth mentioning that I did try building 3.3.6-NAPI out of tree and the issue persists with that.

