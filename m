From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 10 Nov 2015 17:38:09 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v3] fm10k: correctly pack
 TLV structures and explain reasoning
In-Reply-To: <1447172869.4094.25.camel@intel.com>
References: <1447106648-5591-1-git-send-email-jacob.e.keller@intel.com>
 <1447172869.4094.25.camel@intel.com>
Message-ID: <1447177089.6967.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-11-10 at 08:27 -0800, Jeff Kirsher wrote:
> On Mon, 2015-11-09 at 14:04 -0800, Jacob Keller wrote:
> > The TLV format for little endian structures is actually 4 byte
> > aligned
> > copy. To this end, we need to add an additional __aligned(4) marker
> > along with __packed to ensure that these structures are actually 4
> > byte
> > aligned and packed correctly. Use of just __packed will not work as
> > this
> > will result in 1byte alignment which is incorrect. Add a comment
> > explaining the reasoning behind why these structures need the
> > special
> > treatment.
> > 
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> > - v3
> > * use __aligned(4) instead of __attribute__(aligned(4))
> > 
> > Note: this patch replaces both TLV patches currently on the queue
> > as
> > it
> > looks like Jeff had forgotten to remove the earlier one when the
> > subject
> > changed.
> 
> Nope, I just applied the last submitted version of this patch. ?Might
> be helpful if the version actually incremented when you re-submit a
> patch. ?This is the third version of "v3", so techincally this should
> have been v5. :-)

At one point there were two different versions on the queue somehow.

It is difficult to remember the version because git doesn't make it
easy to keep track of the version. I'm currently working on how to
integrate git-notes into my workflow for this sort of thing.

Regards,
Jake
