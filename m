From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 23 Aug 2018 09:44:28 -0700
Subject: [Intel-wired-lan] [PATCH v6 01/11] igc: Add skeletal frame for
 Intel(R) 2.5G Ethernet Controller support.
In-Reply-To: <77e2a16b-b6e8-0a31-7c85-78186166bd45@oracle.com>
References: <20180823070552.12190-1-sasha.neftin@intel.com>
 <77e2a16b-b6e8-0a31-7c85-78186166bd45@oracle.com>
Message-ID: <2d93bc35f188a9e483fd9e86a0164d662d3af3e3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2018-08-23 at 09:37 -0700, Shannon Nelson wrote:
> On 8/23/2018 12:05 AM, Sasha Neftin wrote:
> > This patch adds the beginning framework onto which I am going to
> > add
> > the igc driver which supports the Intel(R) I225-LM/I225-V 2.5G
> > Ethernet Controller.
> > 
> > Sasha Neftin (v2):
> > update module author, copyright and licence header
> > cosmetic changes
> > 
> > Sasha Neftin (v3):
> > remove unused header files
> > 
> > Sasha Neftin (v4):
> > update brand name
> > fix syntax by input from community
> > replace e1000_ prefix with igc_ prefix
> > 
> > Sasha Neftin (v5):
> > no changes
> > 
> > Sasha Neftin (v6):
> > no changes
> 
> In all these patches, this version stuff will be removed from the
> commit 
> message before pushing upstream, right?
> 
> Normally they appear after the "---" so as to not be a part of the 
> formal commit message saved in git.

Yes, when this eventually gets pushed upstream, the changelog will be
stripped.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180823/2dd489bb/attachment.asc>
