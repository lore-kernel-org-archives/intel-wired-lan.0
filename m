From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 27 Sep 2017 14:33:49 +0300
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix limit imprecise of the
 number of MAC/VLAN that can be added for VFs
In-Reply-To: <1506495497-10736-1-git-send-email-wangyunjian@huawei.com>
References: <1506495497-10736-1-git-send-email-wangyunjian@huawei.com>
Message-ID: <fd104583-6743-9f1b-cba8-988fa1b216db@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello!

On 9/27/2017 9:58 AM, w00273186 wrote:

> From: Yunjian Wang <wangyunjian@huawei.com>
> 
> Now it don't limit the number of MAC/VLAN strictly. When there is more

    Doesn't.

> elements in the virtchnl MAC/VLAN list, it can still add successfully.
> 
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

[...]

MBR, Sergei
