From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Thu, 16 Jul 2015 17:58:19 +0300
Subject: [Intel-wired-lan] [PATCH v7 1/3] if_link: Add control trust VF
In-Reply-To: <7F861DC0615E0C47A872E6F3C5FCDDBD05F039BA@BPXM14GP.gisp.nec.co.jp>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05F039BA@BPXM14GP.gisp.nec.co.jp>
Message-ID: <CAJ3xEMig4ZBV3Uwt_EPG6W_AWrqJinGr=ziBSpCqFPpXuaUPUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jul 16, 2015 at 1:33 PM, Hiroshi Shimamoto
<h-shimamoto@ct.jp.nec.com> wrote:
> From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
>
> Add netlink directives and ndo entry to trust VF user.

You haven't posted cover letter stating the V7 --> V6 and V6 --> older
versions changes

Or.


> This controls the special permission of VF user.
> The administrator will dedicatedly trust VF user to use some features
> which impacts security and/or performance.
>
> The administrator never turn it on unless VF user is fully trusted.
>
> Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> CC: Choi, Sy Jong <sy.jong.choi@intel.com>
