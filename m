From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Tue, 1 Dec 2020 09:58:52 +0100
Subject: [Intel-wired-lan] [PATCH v4 2/6] igb: take vlan double header
 into account
In-Reply-To: <DM6PR11MB454615FDFC4E7B71D9B82FA29CF40@DM6PR11MB4546.namprd11.prod.outlook.com>
References: <20201111170453.32693-1-sven.auhagen@voleatech.de>
 <20201111170453.32693-3-sven.auhagen@voleatech.de>
 <DM6PR11MB454615FDFC4E7B71D9B82FA29CF40@DM6PR11MB4546.namprd11.prod.outlook.com>
Message-ID: <20201201095852.2dc1e8f8@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 1 Dec 2020 08:23:23 +0000
"Penigalapati, Sandeep" <sandeep.penigalapati@intel.com> wrote:

> Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>

Very happy that you are testing this.

Have you also tested that samples/bpf/ xdp_redirect_cpu program works?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

