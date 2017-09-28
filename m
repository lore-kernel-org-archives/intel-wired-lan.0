From: wangyunjian <wangyunjian@huawei.com>
Date: Thu, 28 Sep 2017 01:32:31 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix limit imprecise of the
 number of MAC/VLAN that can be added for VFs
In-Reply-To: <fd104583-6743-9f1b-cba8-988fa1b216db@cogentembedded.com>
References: <1506495497-10736-1-git-send-email-wangyunjian@huawei.com>
 <fd104583-6743-9f1b-cba8-988fa1b216db@cogentembedded.com>
Message-ID: <34EFBCA9F01B0748BEB6B629CE643AE60C64A993@dggemm513-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks, I will send the v2 later.

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sergei.shtylyov at cogentembedded.com]
> Sent: Wednesday, September 27, 2017 7:34 PM
> To: wangyunjian <wangyunjian@huawei.com>; davem at davemloft.net;
> jeffrey.t.kirsher at intel.com
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; caihe
> <caihe@huawei.com>
> Subject: Re: [PATCH net] i40e: Fix limit imprecise of the number of
> MAC/VLAN that can be added for VFs
> 
> Hello!
> 
> On 9/27/2017 9:58 AM, w00273186 wrote:
> 
> > From: Yunjian Wang <wangyunjian@huawei.com>
> >
> > Now it don't limit the number of MAC/VLAN strictly. When there is more
> 
>     Doesn't.
> 
> > elements in the virtchnl MAC/VLAN list, it can still add successfully.
> >
> > Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> 
> [...]
> 
> MBR, Sergei
