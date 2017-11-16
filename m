From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 16 Nov 2017 14:01:12 -0800
Subject: [Intel-wired-lan] [PATCH 0/7] [RESEND] [net] intel: Use smp_rmb
 rather than read_barrier_depends
In-Reply-To: <f360a8cd-518c-1df5-5ffd-91a0e9688ce2@linux.vnet.ibm.com>
References: <1510846675-15169-1-git-send-email-brking@linux.vnet.ibm.com>
 <20171116113358.00001d5a@intel.com>
 <f360a8cd-518c-1df5-5ffd-91a0e9688ce2@linux.vnet.ibm.com>
Message-ID: <20171116140112.00007c89@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 16 Nov 2017 14:03:02 -0600
Brian King <brking@linux.vnet.ibm.com> wrote:
> I did think about changing the powerpc definition of read_barrier_depends,
> but after reading up on that barrier, decided it was not the correct barrier
> to be used in this context. Here is some good historical background on
> read_barrier_depends that I found, along with an example.
> 
> https://lwn.net/Articles/5159/
> 
> Since there is no data-dependency in the code in question here, I think
> the smp_rmb is the proper barrier to use.

Hey Brian, thanks for the explanation, I'll agree with you and Alex
that the smb_rmb replacement is okay.  Does your test still pass
without the ->skb NULLs?
