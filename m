From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 8 Jan 2021 10:23:22 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 1/2] net: core: count
 drops from GRO
In-Reply-To: <5badc441-6de9-54cf-2b72-d67572cbb105@intel.com>
References: <20210106215539.2103688-1-jesse.brandeburg@intel.com>
 <20210106215539.2103688-2-jesse.brandeburg@intel.com>
 <5badc441-6de9-54cf-2b72-d67572cbb105@intel.com>
Message-ID: <20210108102322.00004b93@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jacob Keller wrote:

> >  	case GRO_DROP:
> > +		atomic_long_inc(&skb->dev->rx_dropped);
> >  		kfree_skb(skb);
> >  		break;
> 
> Would it makes sense to have this be a different stat? or is it really
> basically the same as the existing rx_dropped, so treating it
> differently wouldn't make much sense..

not sure, was hoping to get feedback here. More later in the thread...
