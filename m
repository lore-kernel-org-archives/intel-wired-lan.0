From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Fri, 25 Jan 2019 15:10:54 -0800
Subject: [Intel-wired-lan] FW: lock dep issue
In-Reply-To: <14063C7AD467DE4B82DEDB5C278E8663BE656FE3@FMSMSX108.amr.corp.intel.com>
References: <14063C7AD467DE4B82DEDB5C278E8663BE656B4C@FMSMSX108.amr.corp.intel.com>
 <1EF4DF93-8A2A-41A0-BC2A-7604B59875A4@intel.com>
 <14063C7AD467DE4B82DEDB5C278E8663BE656FE3@FMSMSX108.amr.corp.intel.com>
Message-ID: <CAM_iQpWBrHQy2-sfNmWkua=yAA8No+F4hiFS9hpGbrKBdxeZFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jan 25, 2019 at 5:03 AM Ruhl, Michael J
<michael.j.ruhl@intel.com> wrote:
>
> Hi,
>
> While running a 5.0.0.rc1 kernel with the LOCKDEP debug configuration turned on, and I saw this LOCKDEP error:
...
>
> I saw this on the console while not doing anything on the system (i.e. no test were running, or any overt network work).
>
> Since this didn't seem like a good thing I thought I would drop this  note.

Yes, the offending commit has been reverted:

commit 5642e27bf6a935c1d0d9149e83d625dfba286463
Author: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date:   Wed Jan 9 09:10:53 2019 -0800

    Revert "igb: reduce CPU0 latency when updating statistics"

Please try a newer kernel.

Thanks for your report.
