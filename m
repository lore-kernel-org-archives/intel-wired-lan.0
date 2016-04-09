From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 08 Apr 2016 23:59:09 -0700
Subject: [Intel-wired-lan] [next-queue PATCH 0/3] Add support for GSO
 partial to Intel NIC drivers
In-Reply-To: <20160408210103.13096.77973.stgit@ahduyck-xeon-server>
References: <20160408203013.12838.63429.stgit@ahduyck-xeon-server>
 <20160408210103.13096.77973.stgit@ahduyck-xeon-server>
Message-ID: <1460185149.2982.6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2016-04-08 at 17:06 -0400, Alexander Duyck wrote:
> So these are the patches needed to enable tunnel segmentation
> offloads on
> the igb, igbvf, ixgbe, and ixgbevf drivers.? In addition this patch
> extends
> the i40e and i40evf drivers to include segmentation support for
> tunnels
> with outer checksums.
> 
> The net performance gain for these patches are pretty significant.?
> In the
> case of i40e a tunnel with outer checksums showed the following
> improvement:
> Throughput Throughput? Local Local?? Result?
> ?????????? Units?????? CPU?? Service Tag????
> ?????????????????????? Util? Demand?????????
> ?????????????????????? %????????????????????
> 14066.29?? 10^6bits/s? 3.49? 0.651?? "before"?
> 20618.16?? 10^6bits/s? 3.09? 0.393?? "after"
> 
> For ixgbe similar results were seen:
> Throughput Throughput? Local? Local?? Result?
> ?????????? Units?????? CPU??? Service Tag????
> ?????????????????????? Util?? Demand?????????
> ?????????????????????? %???????????????
> 12879.89?? 10^6bits/s? 10.00? 0.763?? "before"
> 14286.77?? 10^6bits/s? 5.74?? 0.395?? "after"?
> 
> These patches all rely on the TSO_MANGLEID and GSO_PARTIAL patches so
> I
> would not recommend applying them until those patches have first been
> applied.

Sorry I did not see this until after I tried applying your series. :-(

Maybe the two dependent patches should have been in the series, so I
and others do not waste their time. ?Or not send this until the two
patches were accepted.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160408/1e0d1721/attachment-0001.asc>
