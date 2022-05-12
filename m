From: Roopa Prabhu <roopa@nvidia.com>
Date: Thu, 12 May 2022 10:17:13 -0700
Subject: [Intel-wired-lan] [PATCH net-next v7 2/2] net: vxlan: Add
 extack support to vxlan_fdb_delete
In-Reply-To: <20220512094743.79f36d81@kernel.org>
References: <cover.1652348961.git.eng.alaamohamedsoliman.am@gmail.com>
 <c6069fb695b25dc2f33e8017023ddd47c58caa8d.1652348962.git.eng.alaamohamedsoliman.am@gmail.com>
 <c5ec2677-3047-8a70-9769-d48a79703220@nvidia.com>
 <20220512094743.79f36d81@kernel.org>
Message-ID: <c6b41db9-78e7-e752-3945-29c70a3d8cb4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 5/12/22 09:47, Jakub Kicinski wrote:
> On Thu, 12 May 2022 09:22:17 -0700 Roopa Prabhu wrote:
>> On 5/12/22 02:55, Alaa Mohamed wrote:
>>> This patch adds extack msg support to vxlan_fdb_delete and vxlan_fdb_parse.
>>> extack is used to propagate meaningful error msgs to the user of vxlan
>>> fdb netlink api
>>>
>>> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> Also the patches don't apply to net-next, again.

that's probably because the patches were already applied. Ido just told 
me abt it also

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=5dd6da25255a9d64622c693b99d7668da939a980

I have requested Alaa send an incremental fix (offline).

thanks

