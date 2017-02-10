From: Yanjun Zhu <yanjun.zhu@oracle.com>
Date: Fri, 10 Feb 2017 10:43:59 +0800
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: add the external ixgbe
 fiber transceiver status
In-Reply-To: <87618083B2453E4A8714035B62D679925074E73F@FMSMSX105.amr.corp.intel.com>
References: <1486609408-6770-1-git-send-email-yanjun.zhu@oracle.com>
 <87618083B2453E4A8714035B62D679925074E73F@FMSMSX105.amr.corp.intel.com>
Message-ID: <589D28EF.1050602@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 2017/2/10 3:08, Tantilov, Emil S wrote:
>> -----Original Message-----
>> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org] On
>> Behalf Of Zhu Yanjun
>> Sent: Wednesday, February 08, 2017 7:03 PM
>> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; broonie at kernel.org;
>> davem at davemloft.net; intel-wired-lan at lists.osuosl.org;
>> netdev at vger.kernel.org
>> Subject: [PATCH 1/1] ixgbe: add the external ixgbe fiber transceiver status
>>
>> When the ixgbe fiber transceiver is external, it is necessary to get
>> the present/absent status of this external ixgbe fiber transceiver.
> The transceiver field was deprecated in the old ethtool API and is being
> removed in the new. This patch will not apply at all once those changes are made:
>
> http://patchwork.ozlabs.org/patch/725081/
Thanks for your kind reply. I will change this patch based on the above 
changes.

Zhu Yanjun
>
> Thanks,
> Emil
>   
>
>

