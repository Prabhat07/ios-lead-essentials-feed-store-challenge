//
//  ManagedCache.swift
//  FeedStoreChallenge
//
//  Created by Prabhat Tiwari on 20/08/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import CoreData

@objc(ManagedCache)
internal class ManagedCache: NSManagedObject {
	@NSManaged var timestamp: Date
	@NSManaged var feed: NSOrderedSet

	static func find(in context: NSManagedObjectContext) throws -> ManagedCache? {
		let request = NSFetchRequest<ManagedCache>(entityName: ManagedCache.entity().name!)
		request.returnsObjectsAsFaults = false
		return try context.fetch(request).first
	}

	static func uniqueInstance(in context: NSManagedObjectContext) throws -> ManagedCache {
		try find(in: context).map(context.delete)
		return ManagedCache(context: context)
	}

	var localFeed: [LocalFeedImage] {
		return feed.compactMap { ($0 as? ManagedFeedImage)?.local }
	}
}