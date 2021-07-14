From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 14 Jul 2021 20:52:32 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: introduce pseudo number of
 cpus for compatibility
In-Reply-To: <CAL+tcoCc+r96Bv8aDXTwY5h_OYTz8sHxdpPW7OuNfdDz+ssYYg@mail.gmail.com>
References: <20210707094133.24597-1-kerneljasonxing@gmail.com>
 <CAL+tcoCc+r96Bv8aDXTwY5h_OYTz8sHxdpPW7OuNfdDz+ssYYg@mail.gmail.com>
Message-ID: <03b846e9906d27ef7a6e84196a0840fdd54ca13d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-07-09 at 15:13 +0800, Jason Xing wrote:
> Oh, one more thing I missed in the last email is that all the
> failures
> are happening on the combination of X722 10GbE and 1GbE. So the value
> of @num_tx_qp  the driver fetches is 384 while the value is 768
> without x722 1GbE.
> 
> I get that information back here:
> $ lspci | grep -i ether
> 5a:00.0 Ethernet controller: Intel Corporation Ethernet Connection
> X722 for 10GbE SFP+ (rev 09)
> 5a:00.1 Ethernet controller: Intel Corporation Ethernet Connection
> X722 for 10GbE SFP+ (rev 09)
> 5a:00.2 Ethernet controller: Intel Corporation Ethernet Connection
> X722 for 1GbE (rev 09)
> 5a:00.3 Ethernet controller: Intel Corporation Ethernet Connection
> X722 for 1GbE (rev 09)
> 
> I know it's really stupid to control the number of online cpus, but
> finding a good way only to limit the @alloc_queue_pairs is not easy
> to
> go. So could someone point out a better way to fix this issue and
> take
> care of some relatively old nics with the number of cpus increasing?

Hi Jason,

Sorry for the slow response; I was trying to talk to the i40e team
about this.

I agree, the limiting of number of online CPUs doesn't seem like a
solution we want to pursue. The team is working on a patch that deals
with the same, or similiar, issue; it is reworking the allocations of
the queue pile. I'll make sure that they add you on the patch when it
is sent so that you can try this and see if it resolves your issue.

Thanks,
Tony

