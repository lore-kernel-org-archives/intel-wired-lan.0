From: Shannon Nelson <shannon.lee.nelson@gmail.com>
Date: Thu, 12 Mar 2020 14:42:41 -0700
Subject: [Intel-wired-lan] [next-queue v2] net/intel: remove driver
 versions from Intel drivers
In-Reply-To: <804857E1F29AAC47BF68C404FC60A184010B09A155@ORSMSX113.amr.corp.intel.com>
References: <20200310232301.2470904-1-jeffrey.t.kirsher@intel.com>
 <804857E1F29AAC47BF68C404FC60A184010B09A155@ORSMSX113.amr.corp.intel.com>
Message-ID: <CAP-MU4NFkHcFLomj8bkzaars+rKmi04vufXs2ZveTGGQ_QJ0wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Mar 10, 2020 at 4:50 PM Allan, Bruce W <bruce.w.allan@intel.com> wrote:
>
> > -----Original Message-----
> > From: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> > Sent: Tuesday, March 10, 2020 4:23 PM
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Allan, Bruce W
> > <bruce.w.allan@intel.com>; Brandeburg, Jesse <jesse.brandeburg@intel.com>;
> > Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Liedtke, Kevin D
> > <kevin.d.liedtke@intel.com>; Rowden, Aaron F <aaron.f.rowden@intel.com>;
> > Keller, Jacob E <jacob.e.keller@intel.com>
> > Subject: [next-queue v2] net/intel: remove driver versions from Intel drivers
> >
> > As with other networking drivers, remove the unnecessary driver version
> > from the Intel drivers. The ethtool driver information and module version
> > will then report the kernel version instead.
>
> The version is still logged in the kernel logfile when the driver is loaded (at least it is in ice).
> Is that still needed/wanted?  Seems redundant to me.
>

FYI - I was "strongly encouraged" to remove the print from ionic's
init function, and you may get this feedback as well.

sln

-- 
==============================================
Mr. Shannon Nelson         Parents can't afford to be squeamish.
