From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 29 Nov 2016 18:44:16 +0000
Subject: [Intel-wired-lan] [PATCH RFC v2] ethtool: implement helper to
	get flow_type value
In-Reply-To: <20161129152144.484bea62@jkicinski-Precision-T1700>
References: <20161128230343.19110-1-jacob.e.keller@intel.com>
 <20161129152144.484bea62@jkicinski-Precision-T1700>
Message-ID: <1480445054.3154.4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-11-29 at 15:21 +0000, Jakub Kicinski wrote:
> On Mon, 28 Nov 2016 15:03:43 -0800, Jacob Keller wrote:
> > +static inline __u32 ethtool_get_flow_spec_type(__u32 flow_type)
> > +{
> > +	return flow_type & (FLOW_EXT | FLOW_MAC_EXT);
> 
> I don't have anything of substance to say but I think you are missing
> a
> negation (~) here compared to the code you are replacing ;)

HAH! Yes you are right. I made a mistake when copying this out of my
driver header file.

Will fix. Sorry for the thrash, and thanks for catching my mistake.

Regards,
Jake
