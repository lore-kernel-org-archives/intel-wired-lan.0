From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 12 May 2022 17:50:56 +0000
Subject: [Intel-wired-lan] [PATCH net-next v7 2/2] net: vxlan: Add
 extack support to vxlan_fdb_delete
In-Reply-To: <c6b41db9-78e7-e752-3945-29c70a3d8cb4@nvidia.com>
References: <cover.1652348961.git.eng.alaamohamedsoliman.am@gmail.com>
 <c6069fb695b25dc2f33e8017023ddd47c58caa8d.1652348962.git.eng.alaamohamedsoliman.am@gmail.com>
 <c5ec2677-3047-8a70-9769-d48a79703220@nvidia.com>
 <20220512094743.79f36d81@kernel.org>
 <c6b41db9-78e7-e752-3945-29c70a3d8cb4@nvidia.com>
Message-ID: <20220512175055.65ftcpkig3t3ttsq@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, May 12, 2022 at 10:17:13AM -0700, Roopa Prabhu wrote:
> 
> On 5/12/22 09:47, Jakub Kicinski wrote:
> > On Thu, 12 May 2022 09:22:17 -0700 Roopa Prabhu wrote:
> > > On 5/12/22 02:55, Alaa Mohamed wrote:
> > > > This patch adds extack msg support to vxlan_fdb_delete and vxlan_fdb_parse.
> > > > extack is used to propagate meaningful error msgs to the user of vxlan
> > > > fdb netlink api
> > > > 
> > > > Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> > Also the patches don't apply to net-next, again.
> 
> that's probably because the patches were already applied. Ido just told me
> abt it also
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=5dd6da25255a9d64622c693b99d7668da939a980
> 
> I have requested Alaa send an incremental fix (offline).
> 
> thanks
>

Alaa, when you send the incremental fixup patch requested by Roopa,
could you please also:

- properly align the extack argument of the ocelot_port_fdb_del()
  function
- properly align the extack argument of the vxlan_fdb_delete() function
- properly align the "DST, VNI, ifindex and port are mutually exclusive with NH_ID"
  string to the open parenthesis of the NL_SET_ERR_MSG macro in vxlan_fdb_parse().
- make actual use of the extack in ice_fdb_add() and ice_fdb_del(), and
  remove the __always_unused from ice_fdb_add().

Thank you.
