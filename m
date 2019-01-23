From: Matthew Wilcox <willy@infradead.org>
Date: Wed, 23 Jan 2019 11:18:02 -0800
Subject: [Intel-wired-lan] [Intel-gfx] [PATCH 1/3] treewide: Lift switch
 variables out of switches
In-Reply-To: <874l9z31c5.fsf@intel.com>
References: <20190123110349.35882-1-keescook@chromium.org>
 <20190123110349.35882-2-keescook@chromium.org>
 <20190123115829.GA31385@kroah.com> <874l9z31c5.fsf@intel.com>
Message-ID: <20190123191802.GB15311@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 23, 2019 at 04:17:30PM +0200, Jani Nikula wrote:
> Can't have:
> 
> 	switch (i) {
> 		int j;
> 	case 0:
>         	/* ... */
> 	}
> 
> because it can't be turned into:
> 
> 	switch (i) {
> 		int j = 0; /* not valid C */
> 	case 0:
>         	/* ... */
> 	}
> 
> but can have e.g.:
> 
> 	switch (i) {
> 	case 0:
> 		{
> 			int j = 0;
> 	        	/* ... */
> 		}
> 	}
> 
> I think Kees' approach of moving such variable declarations to the
> enclosing block scope is better than adding another nesting block.

Another nesting level would be bad, but I think this is OK:

	switch (i) {
	case 0: {
		int j = 0;
        	/* ... */
	}
	case 1: {
		void *p = q;
		/* ... */
	}
	}

I can imagine Kees' patch might have a bad effect on stack consumption,
unless GCC can be relied on to be smart enough to notice the
non-overlapping liveness of the vriables and use the same stack slots
for both.
