From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 19 May 2021 18:46:58 +0000
Subject: [Intel-wired-lan] [PATCH net v4] igb: Fix XDP with PTP enabled
In-Reply-To: <20210519153418.00c4cc42@carbon>
References: <20210503072800.79936-1-kurt@linutronix.de>
 <20210504102827.342f6302@carbon> <20210519153418.00c4cc42@carbon>
Message-ID: <e4568dc225edd00122b35be37cef9fac68329508.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-05-19 at 15:34 +0200, Jesper Dangaard Brouer wrote:
> Hi Maintainers,
> 
> What is the status on this patch?

I'm awaiting testing from our validation. They expect to finish by the
end of the week; I'll send out the patch as soon as they've completed.

Thanks,
Tony


> I don't see this fix being applied on git-trees net or net-next.
> 
> [0] 20210503072800.79936-1-kurt at linutronix.de
> [1] 
> https://patchwork.kernel.org/project/netdevbpf/patch/20210503072800.79936-1-kurt at linutronix.de/
> [2] 
> https://lore.kernel.org/netdev/20210503072800.79936-1-kurt at linutronix.de/
> 
