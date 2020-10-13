From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Tue, 13 Oct 2020 10:26:52 +0000
Subject: [Intel-wired-lan] [PATCH] i40e,
 xsk: uninitialized variable in i40e_clean_rx_irq_zc()
In-Reply-To: <20200916143228.GA764370@mwanda>
References: <20200916143228.GA764370@mwanda>
Message-ID: <SN6PR11MB3008497E4E77166FE98A9CBDE2040@SN6PR11MB3008.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Dan Carpenter
Sent: Wednesday, September 16, 2020 8:02 PM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan at lists.osuosl.org; kernel-janitors at vger.kernel.org; Topel, Bjorn <bjorn.topel@intel.com>
Subject: [Intel-wired-lan] [PATCH] i40e, xsk: uninitialized variable in i40e_clean_rx_irq_zc()



The "failure" variable is used without being initialized.  It should be set to false.



Fixes: 8cbf74149903 ("i40e, xsk: move buffer allocation out of the Rx processing loop")

Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com<mailto:dan.carpenter@oracle.com>>

---

drivers/net/ethernet/intel/i40e/i40e_xsk.c | 2 +-

1 file changed, 1 insertion(+), 1 deletion(-)



Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201013/ee128d11/attachment.html>
