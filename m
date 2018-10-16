From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 16 Oct 2018 13:59:45 +0300
Subject: [Intel-wired-lan] [PATCH] ice: remove an unneeded NULL check
In-Reply-To: <804857E1F29AAC47BF68C404FC60A184F24B35A4@FMSMSX151.amr.corp.intel.com>
References: <20181012071709.GA10212@mwanda>
 <804857E1F29AAC47BF68C404FC60A184F24B35A4@FMSMSX151.amr.corp.intel.com>
Message-ID: <20181016105945.6ryege7672uhnnwd@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 15, 2018 at 04:18:35PM +0000, Allan, Bruce W wrote:
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> > Of Dan Carpenter
> > Sent: Friday, October 12, 2018 12:17 AM
> > To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Ertman, David M
> > <david.m.ertman@intel.com>
> > Cc: kernel-janitors at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [PATCH] ice: remove an unneeded NULL check
> > 
> > We added a NULL check in commit 072f0c3db9da ("ice: Fix potential null
> > pointer issues") but it causes static checker warnings.
> 
> Which static checker and with what options?
> 

Future versions of Smatch will complain probably.  It turns out there
are many many unnecessary NULL checks and they seldome indicate a bug so
I'm waffling on this...

regards,
dan carpenter

