From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Mon, 15 Aug 2016 20:58:15 +0000
Subject: [Intel-wired-lan] ixgbe panic on ethtool after interface down/up
In-Reply-To: <CAPeXnHs=7G_R8spwEsZmiFV2Yu19bbumQBC4OZemsOGBMVwMuQ@mail.gmail.com>
References: <CAPeXnHs=7G_R8spwEsZmiFV2Yu19bbumQBC4OZemsOGBMVwMuQ@mail.gmail.com>
Message-ID: <87618083B2453E4A8714035B62D67992506C9040@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>Behalf Of Matthew Garrett
>Sent: Monday, August 15, 2016 1:35 PM
>To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
>lan at lists.osuosl.org
>Subject: [Intel-wired-lan] ixgbe panic on ethtool after interface down/up
>
>We're seeing the following panic on ixgbe after running ethtool -K
>ens802f0 l2-fwd-offload on:

Which kernel version and what device are you using in this test?

We did have similar crashes reported due to a race in the service task.
Unless you are running current pull from our dev tree, you may want to give
this patch a try:
http://patchwork.ozlabs.org/patch/654205/

Thanks,
Emil

