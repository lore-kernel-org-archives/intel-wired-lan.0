From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Tue, 8 Dec 2020 09:28:03 +0100
Subject: [Intel-wired-lan] [PATCH v2 bpf 1/5] net: ethtool: add xdp
 properties flag set
In-Reply-To: <431a53bd-25d7-8535-86e1-aa15bf94e6c3@gmail.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com>
 <878sad933c.fsf@toke.dk>
 <20201204124618.GA23696@ranger.igk.intel.com>
 <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
 <20201207135433.41172202@carbon>
 <5fce960682c41_5a96208e4@john-XPS-13-9370.notmuch>
 <431a53bd-25d7-8535-86e1-aa15bf94e6c3@gmail.com>
Message-ID: <20201208092803.05b27db3@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 7 Dec 2020 18:01:00 -0700
David Ahern <dsahern@gmail.com> wrote:

> On 12/7/20 1:52 PM, John Fastabend wrote:
> >>
> >> I think we need to keep XDP_TX action separate, because I think that
> >> there are use-cases where the we want to disable XDP_TX due to end-user
> >> policy or hardware limitations.  
> > 
> > How about we discover this at load time though. 

Nitpick at XDP "attach" time. The general disconnect between BPF and
XDP is that BPF can verify at "load" time (as kernel knows what it
support) while XDP can have different support/features per driver, and
cannot do this until attachment time. (See later issue with tail calls).
(All other BPF-hooks don't have this issue)

> > Meaning if the program
> > doesn't use XDP_TX then the hardware can skip resource allocations for
> > it. I think we could have verifier or extra pass discover the use of
> > XDP_TX and then pass a bit down to driver to enable/disable TX caps.
> >   
> 
> This was discussed in the context of virtio_net some months back - it is
> hard to impossible to know a program will not return XDP_TX (e.g., value
> comes from a map).

It is hard, and sometimes not possible.  For maps the workaround is
that BPF-programmer adds a bound check on values from the map. If not
doing that the verifier have to assume all possible return codes are
used by BPF-prog.

The real nemesis is program tail calls, that can be added dynamically
after the XDP program is attached.  It is at attachment time that
changing the NIC resources is possible.  So, for program tail calls the
verifier have to assume all possible return codes are used by BPF-prog.

BPF now have function calls and function replace right(?)  How does
this affect this detection of possible return codes?


> Flipping that around, what if the program attach indicates whether
> XDP_TX could be returned. If so, driver manages the resource needs. If
> not, no resource needed and if the program violates that and returns
> XDP_TX the packet is dropped.

I do like this idea, as IMHO we do need something that is connected
with the BPF-prog, that describe what resources the program request
(either like above via detecting this in verifier, or simply manually
configuring this in the BPF-prog ELF file)

The main idea is that we all (I assume) want to provide a better
end-user interface/experience. By direct feedback to the end-user that
"loading+attaching" this XDP BPF-prog will not work, as e.g. driver
don't support a specific return code.  Thus, we need to reject
"loading+attaching" if features cannot be satisfied.

We need a solution as; today it is causing frustration for end-users
that packets can be (silently) dropped by XDP, e.g. if driver don't
support XDP_REDIRECT.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

