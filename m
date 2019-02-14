From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Thu, 14 Feb 2019 21:28:53 +0000
Subject: [Intel-wired-lan] [net] ixgbe: fix older devices that do not
 support IXGBE_MRQC_L3L4TXSWEN
In-Reply-To: <315E3AFC3F1FCC4A88C68B5581547E0682A71DE4@dggemm513-mbx.china.huawei.com>
References: <315E3AFC3F1FCC4A88C68B5581547E0682A71DE4@dggemm513-mbx.china.huawei.com>
Message-ID: <87618083B2453E4A8714035B62D67992EC2165F5@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
>Behalf Of Xuguizhu (Guzhu Xu, Intelligent Computing Business Dept)
>Sent: Wednesday, February 13, 2019 7:48 PM
>Subject: Re: [Intel-wired-lan] [net] ixgbe: fix older devices that do
>not support IXGBE_MRQC_L3L4TXSWEN
>
>Hi guys:
>	We would like to know what kind of issues this patch may cause
>before it is modified, or what triggers you to make this change. How can
>we reproduce this issue in the lab? The cards we can find in our lab are
>82599, X540 and X550. Please guide us to verify this issue, thank you
>very much. After comparing the data sheets of the 82599 and X550, we
>found that the L3L4TXSWEN bit in the 82599 NIC is reserved, but this
>flag is writable.

This patch is resolving a bug that was reported on 82599 where a packet loss
(as a side effect of out-of-order packets) was observed by a user in their
environment. The packet loss was bisected to the patch that introduced the
write to MRQC.L3L4TXSWEN. The reason this bit is needed on X550 is to allow
for RSS hashing of traffic between VFs. Parts older than X550 do not support
per-VF RSS configuration and hence this bit should not be set.

Thanks,
Emil

