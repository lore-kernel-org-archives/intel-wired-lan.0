From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Mon,  2 May 2022 17:17:35 +0200
Subject: [Intel-wired-lan] question about intel wired patchwork
In-Reply-To: <a683810b6ef8135486fde3b4d3286332d70100f7.camel@redhat.com>
References: <a683810b6ef8135486fde3b4d3286332d70100f7.camel@redhat.com>
Message-ID: <20220502151735.4051393-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paolo Abeni <pabeni@redhat.com>
Date: Mon, 02 May 2022 17:14:16 +0200

> Hello,

Hey,

> 
> This patch:
> 
> https://patchwork.ozlabs.org/project/intel-wired-lan/patch/e36724d3cdfbedf9af1a2a7f47ebd60aa7932f83.1650978540.git.lorenzo at kernel.org/
> 
> is stuck in the 'Awaiting Upstream' status since a while. What does
> that mean? In the netdev patchwork the same status for such patch would
> mean that we expect it to go trough the intel wired driver tree, so
> it's a little confusing to me.

Yes, it will go through the IWL list, XDP + ixgbe teams are
currently reviewing and testing it since we have some changes on our
side on the same topic.

> 
> What are the better options to move it forward?
> 
> Thanks!
> 
> Paolo

Thanks,
Al
