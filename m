From: Wang, Dongsheng <dongsheng.wang@hxt-semitech.com>
Date: Fri, 7 Sep 2018 17:29:49 +0000
Subject: [Intel-wired-lan] [PATCH v3 2/2] net: ethernet: i40evf: fix
 underlying build error
References: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <1536319175-3660-3-git-send-email-dongsheng.wang@hxt-semitech.com>
 <77898840b49847a7a835b20b383e21a2@HXTBJIDCEMVIW02.hxtcorp.net>
 <9BBC4E0CF881AA4299206E2E1412B6267C604A79@ORSMSX102.amr.corp.intel.com>
Message-ID: <5ed6f32940644d7f9a13ac55e2015165@HXTBJIDCEMVIW02.hxtcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/7/2018 11:27 PM, Wyborny, Carolyn wrote:
>> -----Original Message-----
>> From: Wang, Dongsheng [mailto:dongsheng.wang at hxt-semitech.com]
>> Sent: Friday, September 07, 2018 5:34 AM
>> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
>> sergei.shtylyov at cogentembedded.com
>> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; davem at davemloft.net;
>> intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
>> kernel at vger.kernel.org; Wyborny, Carolyn <carolyn.wyborny@intel.com>
>> Subject: Re: [PATCH v3 2/2] net: ethernet: i40evf: fix underlying build error
>>
>> Hello Jacob,
>>
>> Since Carolyn' team is working this, I think we don't need this patch
>> anymore because this header file is only for ethtool.c.
>> [..]
> Hello Dongsheng,
>
> The commonization effort we're working on is prioritizing our newest drivers.  The i40e work is still being scoped, so we should fix this problem as needed now and not wait.

After Sergei agree.  ;)


Cheers,

Dongsheng

> I apologize for any miscommunication.  Was trying to let people know that we aware of the issue and are trying to make progress in that direction.
>
> Thanks,
>
> Carolyn
>

