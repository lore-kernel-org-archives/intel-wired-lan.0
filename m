From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Fri, 25 Sep 2020 19:18:11 -0400
Subject: [Intel-wired-lan] [PATCH v3 4/4] PCI: Limit
 pci_alloc_irq_vectors() to housekeeping CPUs
In-Reply-To: <256490f0-0762-447c-a7be-0e5a6bb04fc4@redhat.com>
References: <20200925202307.GA2456332@bjorn-Precision-5520>
 <256490f0-0762-447c-a7be-0e5a6bb04fc4@redhat.com>
Message-ID: <0f19925c-a6f7-fbab-46c9-f3af389708d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 9/25/20 5:38 PM, Nitesh Narayan Lal wrote:
> On 9/25/20 4:23 PM, Bjorn Helgaas wrote:

[...]

>>> +	/*
>>> +	 * If we have isolated CPUs for use by real-time tasks, to keep the
>>> +	 * latency overhead to a minimum, device-specific IRQ vectors are moved
>>> +	 * to the housekeeping CPUs from the userspace by changing their
>>> +	 * affinity mask. Limit the vector usage to keep housekeeping CPUs from
>>> +	 * running out of IRQ vectors.
>>> +	 */
>>> +	if (hk_cpus < num_online_cpus()) {
>>> +		if (hk_cpus < min_vecs)
>>> +			max_vecs = min_vecs;
>>> +		else if (hk_cpus < max_vecs)
>>> +			max_vecs = hk_cpus;
>>> +	}
>> It seems like you'd want to do this inside
>> pci_alloc_irq_vectors_affinity() since that's an exported interface,
>> and drivers that use it will bypass the limiting you're doing here.
> Good point, few drivers directly use this.
> I took a quick look and it seems I may also have to take the pre and the
> post vectors into consideration.
>

It seems my initial interpretation was incorrect, reserved vecs (pre+post)
should always be less than the min_vecs.
So, FWIU we should be fine in limiting the max_vecs.

I can make this change and do a repost.

Do you have any other concerns with this patch or with any of the other
patches?

[...]

-- 
Nitesh

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200925/bf536ca2/attachment.asc>
