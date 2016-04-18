From: Joe Perches <joe@perches.com>
Date: Mon, 18 Apr 2016 10:00:19 -0700
Subject: [Intel-wired-lan] [PATCH net-next V2 2/2] intel: ixgbevf:
 Support Windows hosts (Hyper-V)
In-Reply-To: <BL2PR03MB19081E9C9AAB13E6F608D08FA06B0@BL2PR03MB1908.namprd03.prod.outlook.com>
References: <1460956943-17560-1-git-send-email-kys@microsoft.com>
 <1460956969-17601-1-git-send-email-kys@microsoft.com>
 <1460956969-17601-3-git-send-email-kys@microsoft.com>
 <CAKgT0UdLxSk6CKVAt232fdthMtUbn9FLru9Q9w1Qjjdv_zKA4g@mail.gmail.com>
 <BL2PR03MB19081E9C9AAB13E6F608D08FA06B0@BL2PR03MB1908.namprd03.prod.outlook.com>
Message-ID: <1460998819.1917.10.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-04-18 at 16:52 +0000, KY Srinivasan wrote:
[]
> > > +bool ixgbevf_on_hyperv(struct ixgbe_hw *hw)
> > > +{
> > > +???????if (hw->mbx.ops.check_for_msg == NULL)
> > > +???????????????return true;
> > > +???????else
> > > +???????????????return false;
> > > +}

trivia:

bool func(...)
{
	if (<bar>)
		return true;
	else
		return false;
}

can generally be written as:

bool func(...)
{
	return <bar>;
}
