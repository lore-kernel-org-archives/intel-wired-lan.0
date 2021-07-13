From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 13 Jul 2021 15:01:53 -0700
Subject: [Intel-wired-lan] [PATCH v3 09/14] ixgbe: Use
 irq_update_affinity_hint
In-Reply-To: <20210713211502.464259-10-nitesh@redhat.com>
References: <20210713211502.464259-1-nitesh@redhat.com>
 <20210713211502.464259-10-nitesh@redhat.com>
Message-ID: <1f083139-4faf-126d-b14c-29d228474d6b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/13/2021 2:14 PM, Nitesh Narayan Lal wrote:
> The driver uses irq_set_affinity_hint() to update the affinity_hint mask
> that is consumed by the userspace to distribute the interrupts. However,
> under the hood irq_set_affinity_hint() also applies the provided cpumask
> (if not NULL) as the affinity for the given interrupt which is an
> undocumented side effect.
>
> To remove this side effect irq_set_affinity_hint() has been marked
> as deprecated and new interfaces have been introduced. Hence, replace the
> irq_set_affinity_hint() with the new interface irq_update_affinity_hint()
> that only updates the affinity_hint pointer.
>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>

Thanks!

Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>


