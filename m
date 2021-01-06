From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Wed, 6 Jan 2021 08:18:25 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Add error message when MTU on
 device is out of the range
In-Reply-To: <20201218165255.6393-1-eryk.roch.rybak@intel.com>
References: <20201218165255.6393-1-eryk.roch.rybak@intel.com>
Message-ID: <SN6PR11MB3008D9DDF45209E14ED85C50E2D00@SN6PR11MB3008.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Eryk

> Rybak

> Sent: Friday, December 18, 2020 10:23 PM

> To: intel-wired-lan at lists.osuosl.org

> Cc: Rybak, Eryk Roch <eryk.roch.rybak@intel.com>

> Subject: [Intel-wired-lan] [PATCH] i40e: Add error message when MTU on device

> is out of the range

>

> When attempting to link XDP prog with MTU larger than supported, user is not

> informed why XDP linking fails. Adding proper error message.

>

> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski at intel.com<mailto:arkadiusz.kubalewski@intel.com>>

> Signed-off-by: Eryk Rybak <eryk.roch.rybak at intel.com<mailto:eryk.roch.rybak@intel.com>>

> ---

>  drivers/net/ethernet/intel/i40e/i40e_main.c | 11 +++++++----

>  1 file changed, 7 insertions(+), 4 deletions(-)

>



Tested-by: George Kuruvinakunnel <george.kuruvinakunnel at intel.com<mailto:george.kuruvinakunnel@intel.com>>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210106/81de3cde/attachment-0001.html>
