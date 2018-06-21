From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 21 Jun 2018 08:52:33 -0700
Subject: [Intel-wired-lan] [bug report] i40e: main driver core
In-Reply-To: <20180621110232.gsup57hb5n7dxny5@kili.mountain>
References: <20180621110232.gsup57hb5n7dxny5@kili.mountain>
Message-ID: <8394dbef-727e-15e9-20f5-839d501c10c3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/21/2018 4:02 AM, Dan Carpenter wrote:
> Hello Jesse Brandeburg,
> 
> The patch 41c445ff0f48: "i40e: main driver core" from Sep 11, 2013,
> leads to the following static checker warning:
> 
> 	drivers/net/ethernet/intel/i40e/i40e_main.c:13065 i40e_veb_setup()
> 	warn: potential off by one 'pf->vsi[]' 'vsi_idx == pf->num_alloc_vsi'
> 
> drivers/net/ethernet/intel/i40e/i40e_main.c
>   13025                           uplink_seid, vsi_seid);
>   13026                  return NULL;
>   13027          }
>   13028
>   13029          /* make sure there is such a vsi and uplink */
>   13030          for (vsi_idx = 0; vsi_idx < pf->num_alloc_vsi; vsi_idx++)
>   13031                  if (pf->vsi[vsi_idx] && pf->vsi[vsi_idx]->seid == vsi_seid)
>   13032                          break;
>   13033          if (vsi_idx >= pf->num_alloc_vsi && vsi_seid != 0) {
>                                                      ^^^^^^^^^^^^^
> I think if pf->num_alloc_vsi is zero then we're going to run into
> problems.  We should remove this condition.

Note how pf->num_alloc_vsi is set in i40e_probe(), it is "guaranteed" to 
be non-zero.  If it is zero we have much bigger issues going on.

We need the == check here to see if we hit the end of the for-loop 
without finding a VSI, the '>' is extra just-in-case checking and really 
is unnecessary.

sln


> 
>   13034                  dev_info(&pf->pdev->dev, "vsi seid %d not found\n",
>   13035                           vsi_seid);
>   13036                  return NULL;
>   13037          }
>   13038
>   13039          if (uplink_seid && uplink_seid != pf->mac_seid) {
>   13040                  for (veb_idx = 0; veb_idx < I40E_MAX_VEB; veb_idx++) {
>   13041                          if (pf->veb[veb_idx] &&
>   13042                              pf->veb[veb_idx]->seid == uplink_seid) {
>   13043                                  uplink_veb = pf->veb[veb_idx];
>   13044                                  break;
>   13045                          }
>   13046                  }
>   13047                  if (!uplink_veb) {
>   13048                          dev_info(&pf->pdev->dev,
>   13049                                   "uplink seid %d not found\n", uplink_seid);
>   13050                          return NULL;
>   13051                  }
>   13052          }
>   13053
>   13054          /* get veb sw struct */
>   13055          veb_idx = i40e_veb_mem_alloc(pf);
>   13056          if (veb_idx < 0)
>   13057                  goto err_alloc;
>   13058          veb = pf->veb[veb_idx];
>   13059          veb->flags = flags;
>   13060          veb->uplink_seid = uplink_seid;
>   13061          veb->veb_idx = (uplink_veb ? uplink_veb->idx : I40E_NO_VEB);
>   13062          veb->enabled_tc = (enabled_tc ? enabled_tc : 0x1);
>   13063
>   13064          /* create the VEB in the switch */
>   13065          ret = i40e_add_veb(veb, pf->vsi[vsi_idx]);
>                                          ^^^^^^^^^^^^^^^^
>   13066          if (ret)
>   13067                  goto err_veb;
> 
> regards,
> dan carpenter
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
